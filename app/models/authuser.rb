class Authuser < ActiveRecord::Base
  attr_accessor :password
  #attr_accessible :name, :password, :level
  validates :name, presence: true
  validates :password, presence: true
  validates :level, numericality: {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 255 }

end
