class AddLengthToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :length, :integer
  end
end
