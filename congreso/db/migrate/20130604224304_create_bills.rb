class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :expediente
      t.string :orden

      t.timestamps
    end
  end
end
