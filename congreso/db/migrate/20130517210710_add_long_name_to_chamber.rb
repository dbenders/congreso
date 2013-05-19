class AddLongNameToChamber < ActiveRecord::Migration
  def change
    add_column :chambers, :long_name, :string
  end
end
