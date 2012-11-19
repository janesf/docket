# == Schema Information
#
# Table name: roles
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  description      :string(255)
#  data_read        :boolean
#  data_write       :boolean
#  system_readwrite :boolean
#

class Roles < ActiveRecord::Base
end
