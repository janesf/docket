class Reminder < ActiveRecord::Base
def dtreminder(user)
    user.push_with_attributes(user, :role =>  time)
  end
has_many :user_reminders
  has_many :users, :through => :user_reminders  
    validates_presence_of :type_id, :event_id, :refdttype_id, :rmdroffset, :rstatus_id, :case_id
  validate :must_have_parent_touse_prioritydate
  validates_numericality_of :rmdroffset

end
