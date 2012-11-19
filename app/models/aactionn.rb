# WRONG ONE!!! AactionN!!

class Aaction < ActiveRecord::Base

  belongs_to :patentcase
  belongs_to :type
  has_many :reminders
  has_many :rules, :through => :types

  validates_presence_of :type_id, :patentcase_id, :dtmailing
  validate :valid_mailing_date?

  def valid_mailing_date?
    unless dtmailing >= Patentcase.find_by_id(:patentcase_id).filingdate && :dtmailing <= Date.today
      errors.add(:dtmailing, 'must not be before the filing date of the application or later than today.')
    end
  end

end
