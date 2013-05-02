class AddChamberToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :chamber_id, :integer
  end
end
