# == Schema Information
#
# Table name: rules
#
#  id         :integer          not null, primary key
#  rule_id    :integer
#  tdesc      :text
#  reminder   :text
#  rmdroffset :date
#  type_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rule < ActiveRecord::Base
  
  attr_accessible :tdesc, :reminder, :rmdroffset, :type_id, :applytowatch, :event_id, :refdttype_id, :desc
  def self.all_refdttypes
    %w(CASEFILING ACTIONMAILING PRIORITY)
  end
  
   belongs_to :type
   belongs_to :event
   belongs_to :aaction
#   has_many :rules, :through => :type
   has_many :reminders, :through => :aaction
 
   validates_presence_of :type_id, :event_id, :refdttype_id, :rmdroffset
   validate :must_have_parent_touse_prioritydate
   validates_numericality_of :rmdroffset
   
   def must_have_parent_touse_prioritydate
      #errors.add_to_base("Patent Must have parent to use priority date") unless Priority.find_by_child_id(:patentcase_id)
   end

end
