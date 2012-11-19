# == Schema Information
#
# Table name: inventors
#
#  id          :integer          not null, primary key
#  inventor_id :integer
#  name        :string(255)
#  entity_id   :integer
#  address     :string(255)
#  state       :string(255)
#  country     :string(255)
#  citizenship :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Inventor < ActiveRecord::Base
  belongs_to :entity
  has_many :inventorships 
  has_many :patentcases, :through => :inventorships, :uniq => true
  
  validates_presence_of :entity_id, :first, :last, :macity, :mapostalcode, :macountry, :mastreet1
  
end
