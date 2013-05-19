class Chamber < ActiveRecord::Base
  attr_accessible :name, :photo_medium, :photo_small, :disabled, :long_name
  has_many :sessions

  def to_s
  	name
  end

  def periods
  	Set.new(sessions.collect {|session| session.period})
  end


end
