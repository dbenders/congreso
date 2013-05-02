class AddFieldsToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :meeting, :integer
    add_column :sessions, :period, :integer
  end
end
