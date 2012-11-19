# == Schema Information
#
# Table name: countrycodes
#
#  id         :integer          not null, primary key
#  ccode      :string(255)
#  cname      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Countrycode < ActiveRecord::Base
    validates_uniqueness_of :ccode

end
