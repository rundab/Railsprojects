class Authuser < ActiveRecord::Base
  attr_accessor :password
  #attr_accessible :name, :password, :level
  validates_uniqueness_of :name
  validates_presence_of :name, :password
end
