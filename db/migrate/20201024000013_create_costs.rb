class CreateCosts < ActiveRecord::Migration[6.0]
  def change
    create_table :costs do |t|
      t.string :title
      t.text :description
      t.integer :transport_time
      t.integer :cost
      t.integer :cost_type
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
