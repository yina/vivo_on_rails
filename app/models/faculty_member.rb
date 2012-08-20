class FacultyMember < ActiveRecord::Base
  has_many :authorships
  has_many :academic_articles, :through => :authorships
  
  attr_accessible :first_name, :last_name, :primary_email
  
  validates :primary_email, :uniqueness => true
  
  # departments will need another table
  searchable do
    text :first_name
    text :last_name
  end
  
  
end
