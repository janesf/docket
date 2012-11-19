class Patentcase < ActiveRecord::Base
  
   belongs_to :entity
   has_many :users, :through => :entities, :uniq => true
   
   
   has_many :inventorships
   has_many :inventors, :through => :inventorships, :uniq => true
   
   #has_and_belongs_to_many :priorities, :class_name => "Patentcase", :join_table => "priorities", :foreign_key => "parent_id", :association_foreign_key => "child_id"
   has_many :priorities, :class_name => "Patentcase"
   
   has_many :aactions
   has_one :most_recent_aaction, :class_name => 'Aaction', :order => 'dtmailing DESC'
   has_many :reminders
   
   validates_associated :inventors, :entity
   validates_presence_of :attorneydocket, :entity_id, :jurisdiction, :responsible
   validates_uniqueness_of :attorneydocket
   
      def before_destroy
         
         # can't delete with associated aactions....
         unless self.aactions.empty? then
            errors.add_to_base("Cannot delete a patent case with associated actions.")
         end
         
         # can't delete with associated users....
         unless self.users.empty? then
            errors.add_to_base("Cannot delete a patent case with associated users.")
         end
         
         # can't delete with associated inventors....
         unless self.inventors.empty? then
            errors.add_to_base("Cannot delete a patent case with associated inventors.")
         end
         
      end

end
