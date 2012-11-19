# == Schema Information
#
# Table name: rstatuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  statuscd   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rstatus < ActiveRecord::Base
end
