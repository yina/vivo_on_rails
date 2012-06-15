class AcademicArticle < ActiveRecord::Base
  attr_accessible :label, :abstract, :issue, :pmid, :datetime
  
  validates :label, :uniqueness => true
end
