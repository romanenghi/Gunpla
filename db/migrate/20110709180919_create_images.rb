class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :gunpla_id
      t.integer :imagetype_id
      t.boolean :defaultimage
      t.string :localpath
      t.string :remotepath

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
