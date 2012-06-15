namespace :vivo do
  desc "Dump Periodicals from VIVO to mysql"
  task :load_periodicals => [:environment] do
    sparql = SPARQL::Client.new("http://172.16.203.132:3030/VIVO/query")
    
    # will need to convert datetime to mysql compatible format
    
    query = %q(PREFIX bibo: <http://purl.org/ontology/bibo/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT distinct ?label
    WHERE{
    ?Journal1 rdf:type bibo:Journal .
    ?Journal1 rdfs:label ?label .
    }
    )
    
    results = sparql.query(query)

    results.each { |result|
      hit = result.to_hash
      
      a = Periodical.new(:label => hit[:label].to_s)
                    
      if a.valid?
        a.save
        puts "putting #{hit[:label]} in database"
      else
        puts "#{hit[:label]} already exists"
      end 
    }
  end
end