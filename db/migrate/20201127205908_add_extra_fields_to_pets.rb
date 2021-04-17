class AddExtraFieldsToPets < ActiveRecord::Migration[6.0]
  def change
    add_column :pets, :age, :integer
    add_column :pets, :weight, :integer
    add_column :pets, :michrochip, :string
    add_column :pets, :is_dog_friendly, :boolean, default: false
    add_column :pets, :is_cat_friendly, :boolean, default: false
    add_column :pets, :is_dominant, :boolean, default: false
    add_column :pets, :is_shows_past_abuse, :boolean, default: false
    add_column :pets, :is_people_friendly, :boolean, default: false
    add_column :pets, :is_barks_alot, :boolean, default: false
  end
end
