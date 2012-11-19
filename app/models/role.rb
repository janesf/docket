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

class Role < ActiveRecord::Base

   # validation
   validates_presence_of     :description
   validates_uniqueness_of   :description

   # relationships
   has_many :users
   
   # processing
   def before_destroy
      
      # can't delete with associated users....
      unless User.find_by_role_id(self.id).nil? then
         errors.add_to_base("Cannot delete a role with associated users.")
      end
      
   end

end
