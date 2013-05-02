class Chamber < ActiveRecord::Base
  attr_accessible :name, :photo_medium, :photo_small, :disabled
  has_many :sessions
end
