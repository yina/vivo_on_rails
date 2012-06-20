class Authorship < ActiveRecord::Base
  belongs_to :academic_article
  belongs_to :faculty_member
  
  attr_accessible :faculty_member_id, :academic_article_id
end
