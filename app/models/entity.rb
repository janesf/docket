# == Schema Information
#
# Table name: entities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  type         :string(255)
#  jurisdiction :string(255)
#  addr1        :string(255)
#  addr2        :string(255)
#  city         :string(255)
#  st           :string(255)
#  zip          :integer
#  country      :string(255)
#  mainphone    :string(255)
#  main         :string(255)
#  contactname  :string(255)
#  contactphone :string(255)
#  contactfax   :string(255)
#  contactemail :string(255)
#  small        :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Entity < ActiveRecord::Base
  
  attr_accessible :name, :type, :jurisdiction, :st, :addr2
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end  
  def self.all_entitytypes
    %w(INDIVIDUAL PARTNERSHIP CORPORATION SOLEPROPRIETORSHIP LAWFIRM)
  end
  has_many :patentcases
  has_many :inventors, through: :patentcases
  has_many :users
  belongs_to :entitytype
  
  default_scope order: 'entities.created_at DESC'
  
  validates_uniqueness_of :name
   
   def before_destroy
      
      # can't delete with associated aactions....
      unless self.inventors.empty? then
         errors.add_to_base("Cannot delete an entity with associated inventors.")
      end
      
      # can't delete with associated patent cases....
      unless self.patentcases.empty? then
         errors.add_to_base("Cannot delete an entity case with associated patent cases.")
      end
      
   end
   
end
