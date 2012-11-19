# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  rating       :string(255)
#  description  :text
#  release_date :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :release_date, :moreinfo

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end
