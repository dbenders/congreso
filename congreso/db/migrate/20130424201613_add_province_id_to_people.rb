class AddProvinceIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :province_id, :integer
  end
end
