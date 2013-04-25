class Province < ActiveRecord::Base
  attr_accessible :name
  has_many :person

  def to_s
  	name
  end  
end
