class AcademicArticle < ActiveRecord::Base
  has_many :authorships
  has_many :faculty_members, :through => :authorships
  
  attr_accessible :label, :abstract, :issue, :pmid, :datetime
  
  validates :label, :uniqueness => true
  
  searchable do
    text :label, :stored => true
    text :abstract, :stored => true
    time :datetime
    string :authorship, :multiple => true do
      faculty_members.map { |faculty_member|
        out = "#{faculty_member.last_name}, #{faculty_member.first_name}"
      }
    end
  end
    
end
