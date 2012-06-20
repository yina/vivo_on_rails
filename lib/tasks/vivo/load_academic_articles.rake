namespace :vivo do
  desc "Dump Academic Articles from VIVO to mysql"
  task :load_academic_articles => [:environment] do
    sparql = SPARQL::Client.new("http://172.16.203.132:3030/VIVO/query")
    
    # will need to convert datetime to mysql compatible format
    
    query = %q(PREFIX bibo: <http://purl.org/ontology/bibo/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX vivo: <http://vivoweb.org/ontology/core#>

    SELECT distinct ?label ?abstract ?issue ?pmid ?dateTime
    WHERE{
    ?AcademicArticle1 rdf:type bibo:AcademicArticle .
    ?AcademicArticle1 rdfs:label ?label .
    OPTIONAL {?AcademicArticle1 bibo:abstract ?abstract .}
    OPTIONAL {?AcademicArticle1 bibo:issue ?issue .}
    OPTIONAL {?AcademicArticle1 bibo:pmid ?pmid .}
    ?AcademicArticle1 vivo:dateTimeValue ?DateTimeValue1 .
    ?DateTimeValue1 rdf:type vivo:DateTimeValue .
    OPTIONAL {?DateTimeValue1 vivo:dateTime ?dateTime .}
    }
    )
    
    results = sparql.query(query)

    results.each { |result|
      hit = result.to_hash
      
      a = AcademicArticle.new(:label => hit[:label].to_s,
                        :abstract => hit[:abstract].to_s,
                        :issue => hit[:issue].to_s,
                        :pmid => hit[:pmid].to_s,
                        :datetime => hit[:dateTime].to_s)
      if a.valid?
        a.save
        puts "putting #{hit[:label]} in database"
      else
        puts "#{hit[:label]} already exists"
      end 
    }
  end
end