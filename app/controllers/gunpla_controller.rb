require 'csv'

class GunplaController < ApplicationController

  def index
	@gunplas = Gunpla.all
	@page_title = "Elenco Gundam"
	cosmicCsvImport
  end
  
  def cosmicimport
	@page_title = "Importazione da cosmic"
  end
  
  def cosmicCsvImport
	CSV.foreach("files/gunpla.csv") do |row|
    if row[0].to_f.to_s != "0.0" then
	    gunpla = Gunpla.new
		gunpla.codiceCosmic = row[0] # Seleziona la colonna n. 0, corrispondente al codice cosmic
		gunpla.descrizioneCosmic = row[2] # Seleziona la colonna n. 2, corrispondente alla descrizione secondo cosmic
		gunpla.cosmicJanCode = row[3] # Importa il cosmic Jan Code
		gunpla.codiceHlj = cosmicToHlj(gunpla.cosmicJanCode)
		gunpla.codiceProdotto = gunpla.codiceHlj
		if Gunpla.where("codiceCosmic = #{gunpla.codiceCosmic}").count == 0 then gunpla.save end
		end 
	end 
  end
  
  def cosmicToHlj(cosmicCode)
	suffix = cosmicCode[0,2]
	result = case suffix
		when "01" then "BAN9" + cosmicCode[2..cosmicCode.length] 
		when "00" then "BAN" + cosmicCode[2..cosmicCode.length] 
		else "Invalid"
	end
	
	return result
end

end
