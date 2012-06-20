namespace :vivo do
  desc "Load connections between faculty and academic articles"
  task :connect_faculty_to_articles => [:environment] do
    sparql = SPARQL::Client.new("http://172.16.203.132:3030/VIVO/query")
    
    # will need to convert datetime to mysql compatible format
    
    query = %q(PREFIX foaf: <http://xmlns.com/foaf/0.1/>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX vivo: <http://vivoweb.org/ontology/core#>

    SELECT distinct ?FacultyMember1_firstName ?FacultyMember1_lastName ?InformationResource1_label
    WHERE{
    ?FacultyMember1 rdf:type vivo:FacultyMember .
    ?FacultyMember1 foaf:firstName ?FacultyMember1_firstName .
    ?FacultyMember1 foaf:lastName ?FacultyMember1_lastName .
    ?FacultyMember1 vivo:authorInAuthorship ?Authorship1 .
    ?Authorship1 rdf:type vivo:Authorship .
    ?Authorship1 vivo:linkedInformationResource ?InformationResource1 .
    ?InformationResource1 rdf:type vivo:InformationResource .
    ?InformationResource1 rdfs:label ?InformationResource1_label .
    }
    )
    
    results = sparql.query(query)

    results.each { |result|
      hit = result.to_hash
      label = hit[:InformationResource1_label].to_s
      first_name = hit[:FacultyMember1_firstName].to_s
      last_name = hit[:FacultyMember1_lastName].to_s
      
      # need to rollback database or remove the updated listings if raise is called.
      
      # get id from faculty database.
      fac = FacultyMember.select("id").where("last_name=? AND first_name=?", last_name, first_name)
      raise "Faculty Member with first: #{first_name} and last: #{last_name} has too many hits" if fac.length > 1
      fac_id = fac.first.id
      
      # get id for academic article
      aca = AcademicArticle.select("id").where("label=?", label)
      raise "no match for #{label}" if aca.first.nil?
      aca_id = aca.first.id
      
      a = Authorship.new(:faculty_member_id => fac_id,
                         :academic_article_id => aca_id)
      a.save
    }
  end
end