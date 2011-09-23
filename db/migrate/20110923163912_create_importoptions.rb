class CreateImportoptions < ActiveRecord::Migration
  def change
    create_table :importoptions do |t|
      t.string :name

      t.timestamps
    end
  end
end
