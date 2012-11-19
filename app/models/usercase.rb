# == Schema Information
#
# Table name: usercases
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  patentcase_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Usercase < ActiveRecord::Base
   belongs_to :user
   belongs_to :patentcase
end
