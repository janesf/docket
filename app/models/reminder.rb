# == Schema Information
#
# Table name: reminders
#
#  id                :integer          not null, primary key
#  dtrmdr            :date
#  patentcase_id     :integer
#  note              :text
#  created_at        :datetime
#  updated_at        :datetime
#  rstatus_id        :integer
#  aaction_id        :integer
#  due_date          :date
#  completed         :boolean
#  completing_action :integer
#  date_completed    :date
#  dismissed         :boolean
#  dismissed_by      :integer
#  date_dismissed    :date
#  rule_id           :integer
#

class Reminder < ActiveRecord::Base
  attr_accessible :dtrmdr, :patentcase_id, :note, :rstatus_id, 
    :rstatus_id, :aaction_id, :due_date, :completed, :date_completed, :completing_action, :dismissed, :rule_id
   belongs_to :patentcase
   belongs_to :aaction
   belongs_to :rule
   def self.all_stats
     %w(ACTIVE COMPLETE DISMISSED)
   end 
  
   def dtreminder(user)
      user.push_with_attributes(user, :role =>  time)
   end

end
