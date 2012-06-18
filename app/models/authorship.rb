class Authorship < ActiveRecord::Base
  belongs_to :academic_article
  belongs_to :faculty_member
  # attr_accessible :title, :body
end
