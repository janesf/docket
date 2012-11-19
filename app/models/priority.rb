# == Schema Information
#
# Table name: priorities
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  childid    :integer
#  created_at :datetime
#  updated_at :datetime
#  note       :text
#

class Priority < ActiveRecord::Base
  attr_accessible :parent_id, :child_id, :watching, :priority
  validates_presence_of :parent_id
  validates_presence_of :child_id
  validate :must_be_others

    def must_be_others
      errors.add_to_base("Must not be linked self.") unless :parent_id != :child_id
    end
end
