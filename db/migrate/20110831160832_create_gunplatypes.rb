class CreateGunplatypes < ActiveRecord::Migration
  def self.up
    create_table :gunplatypes do |t|
      t.string :name
      t.integer :codiceinterno
      t.text :description
      t.string :image
      t.integer :order
      t.string :sigla
      
      t.timestamps
    end
  end

  def self.down
    drop_table :gunplatypes
  end
end
