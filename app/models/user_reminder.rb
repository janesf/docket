# == Schema Information
#
# Table name: user_reminders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  reminder_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class UserReminder < ActiveRecord::Base
   belongs_to :users
   belongs_to :reminders
   validates_presence_of :user_id, :reminder_id
end
