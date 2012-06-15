class CreateAcademicArticles < ActiveRecord::Migration
  def change
    create_table :academic_articles do |t|
      t.text :label
      t.string :abstract
      t.text :pmid
      t.text :issue
      t.datetime :datetime # ontology datetime is a string value
      t.timestamps
    end
  end
end
