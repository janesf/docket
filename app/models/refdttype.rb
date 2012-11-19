class Refdttype < ActiveRecord::Base
  
   has_many :rules
  
   validates_uniqueness_of :dttype

end
