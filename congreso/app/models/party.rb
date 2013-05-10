class Party < ActiveRecord::Base
  attr_accessible :facebook, :name, :photo_medium, :photo_small, :twitter, :website, :wikipedia, :acronym
  has_many :people


  def to_s
  	name
  end
end
