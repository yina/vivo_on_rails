namespace :vivo do
  desc "Connects to sparql VIVO endpoint and loads data into mysql"
  task :load_mysql_from_jena do
    # Open config file and read in SPARQL endpoint information
    
    # Test SPARQL endpoint connection
    # Print out error if cannot connect to SPARQL endpoint.
    
    
    # use rdf.rb and issue SPARQL endpoint query to connect to jena database
    
    # issue SPARQL query to fill in faculty members database
    
    puts "Test"
  end
  
  desc "Dump Faculty Members from VIVO to mysql"
  task :load_faculty_members => [:environment] do
    # need to move sparql endpoint to file in config directory.
    sparql = SPARQL::Client.new("http://172.16.203.132:3030/VIVO/query")

    query = %q(
    PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX vivo: <http://vivoweb.org/ontology/core#>

    SELECT distinct ?firstName ?lastName ?primaryEmail
    WHERE{
    ?FacultyMember rdf:type vivo:FacultyMember .
    ?FacultyMember foaf:firstName ?firstName .
    ?FacultyMember foaf:lastName ?lastName .
    ?FacultyMember vivo:primaryEmail ?primaryEmail .
    }
    )

    results = sparql.query(query)

    results.each { |result|
      hit = result.to_hash
      f = FacultyMember.new(:first_name => hit[:firstName].to_s,
                        :last_name => hit[:lastName].to_s,
                        :primary_email => hit[:primaryEmail].to_s)
      if f.valid?
        f.save
        puts "putting #{hit[:firstName]} in database"
      else
        puts "#{hit[:primaryEmail]} already exists"
      end 
      
    }
  end
  
end