class Party < ActiveRecord::Base
  attr_accessible :facebook, :name, :photo_medium, :photo_small, :twitter, :website, :wikipedia
  has_many :person


  def to_s
  	name
  end
end
