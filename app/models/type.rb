# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  type_id    :integer
#  desc       :string(255)
#  final      :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Type < ActiveRecord::Base
   
   has_many :rules
   has_many :aactions

   validates_presence_of :descrp
   validates_uniqueness_of :descrp

end
