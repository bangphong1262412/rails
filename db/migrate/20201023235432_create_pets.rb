class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :title
      t.boolean :active, default: false 
      t.string :video
      t.boolean :is_spayed, default: false
      t.boolean :has_one_transport_cost, default: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
