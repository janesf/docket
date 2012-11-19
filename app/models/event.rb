class Event < ActiveRecord::Base
   
   has_many :rules
   
   validates_uniqueness_of :event

end
