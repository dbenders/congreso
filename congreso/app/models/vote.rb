class Vote < ActiveRecord::Base
  attr_accessible :bill_id, :person_id, :vote
end
