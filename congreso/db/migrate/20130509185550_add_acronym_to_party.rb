class AddAcronymToParty < ActiveRecord::Migration
  def change
    add_column :parties, :acronym, :string
  end
end
