class AddDisabledToChamber < ActiveRecord::Migration
  def change
    add_column :chambers, :disabled, :boolean
  end
end
