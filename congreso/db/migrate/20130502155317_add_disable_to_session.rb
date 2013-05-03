class AddDisableToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :disabled, :boolean
  end
end
