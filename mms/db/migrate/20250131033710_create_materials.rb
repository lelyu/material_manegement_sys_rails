class CreateMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :location
      t.integer :quantity
      t.string :instructor
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
