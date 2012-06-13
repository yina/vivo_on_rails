class FacultyMember < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :primary_email
  
  validates :primary_email, :uniqueness => true
  
  # departments will need another table
end
