class CreateGunplaCategories < ActiveRecord::Migration
  def self.up
    create_table :gunpla_categories do |t|
      t.integer :gunpla_id
      t.integer :category_id
      t.boolean :primary
      t.timestamps
    end
  end

  def self.down
    drop_table :gunpla_categories
  end
end
