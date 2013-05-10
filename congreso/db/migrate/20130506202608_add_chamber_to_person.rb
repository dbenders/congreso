class AddChamberToPerson < ActiveRecord::Migration
  def change
    add_column :people, :chamber_id, :integer
  end
end
