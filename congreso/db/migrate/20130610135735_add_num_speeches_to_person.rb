class AddNumSpeechesToPerson < ActiveRecord::Migration
  def change
    add_column :people, :num_speeches, :integer
  end
end
