class Bookmark < ActiveRecord::Base
  attr_accessible :pos, :typ
  belongs_to :session
  has_one :person
end
