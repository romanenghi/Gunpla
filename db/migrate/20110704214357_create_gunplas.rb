class CreateGunplas < ActiveRecord::Migration
  def self.up
    create_table :gunplas do |t|
	  t.string :codiceProdotto
	  t.string :codiceCosmic
	  t.string :codiceHlj
	  t.string :codice1999
	  t.string :cosmicJanCode
	  t.string :descrizione
	  t.string :descrizioneHlj
	  t.string :descrizione1999
	  t.string :descrizioneCosmic
	  t.string :janCode
      t.timestamps
    end
  end

  def self.down
    drop_table :gunplas
  end
end
