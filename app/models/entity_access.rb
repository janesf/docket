# == Schema Information
#
# Table name: entities_users
#
#  entity_id :integer
#  user_id   :integer
#

class EntityAccess < ActiveRecord::Base
   set_table_name "entities_users"
end
