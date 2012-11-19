# == Schema Information
#
# Table name: inventorships
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  inventor_id   :integer
#  patentcase_id :integer
#

class Inventorship < ActiveRecord::Base
   # JDI: using Agile Web ...3rd pp.366 et seq.
   # 
   # I think it's just this simple....
   
   #has_many :patentcases
   belongs_to :patentcase
   #has_many :inventors
   belongs_to :inventor
   #has_and_belongs_to_many :patentcase
   #has_and_belongs_to_many :inventor
   #belongs_to :entity
   validates_presence_of :patentcase_id, :inventor_id
   
   # JDI:  uniqueness enforced by :inventor and :patentcase
   
   #validate :must_be_unique
   
   #def must_be_unique
   #   errors.add_to_base("Must be unique ") unless (Inventorship.find(:first, :conditions => ['patentcase_id = ? and inventor_id = #?',:patentcase_id,:inventor_id]).nil?)
   #end
   
end
