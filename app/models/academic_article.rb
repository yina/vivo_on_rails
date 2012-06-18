class AcademicArticle < ActiveRecord::Base
  has_many :authorships
  has_many :faculty_members, :through => :authorships
  
  attr_accessible :label, :abstract, :issue, :pmid, :datetime
  
  validates :label, :uniqueness => true
end
