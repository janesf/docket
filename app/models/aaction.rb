# Unable to annotate aaction.rb: Could not find table 'aactions'
# Unable to annotate actionrulelink.rb: Could not find table 'actionrulelinks'
# Unable to annotate entitytype.rb: Could not find table 'entitytypes'
# Unable to annotate event.rb: Could not find table 'events'
# Unable to annotate mytest.rb: Could not find table 'mytests'
# Unable to annotate patentcase.rb: Primary key is not allowed in a has_and_belongs_to_many join table (priorities).
# Unable to annotate refdttype.rb: Could not find table 'refdttypes'
# Unable to annotate rulereminderlink.rb: Could not find table 'rulereminderlinks'
# Unable to annotate task.rb: Could not find table 'tasks'


class Aaction < ActiveRecord::Base

  attr_accessor :dtmailing

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  
   belongs_to :patentcase
   belongs_to :type
   has_many :reminders
   has_many :rules, :through => :type
   
   validates_presence_of :type_id, :patentcase_id, :dtmailing
   validate :valid_mailing_date?
   
   def valid_mailing_date?
      unless Patentcase.find_by_id(patentcase_id).filingdate.nil? then
         unless Patentcase.find_by_id(patentcase_id).filingdate != '' and 
            dtmailing >= Patentcase.find_by_id(patentcase_id).filingdate and 
            dtmailing <= Date.today then
               errors.add(:dtmailing, 'must not be before the filing date of the application or later than today.')
         end
      end
   end

   def before_destroy
      unless self.reminders.empty? then
         errors.add_to_base("Cannot delete an action with associated reminders.")
      end
   end

end
