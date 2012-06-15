class Periodical < ActiveRecord::Base
  attr_accessible :label
  
  validates :label, :uniqueness => true
end
