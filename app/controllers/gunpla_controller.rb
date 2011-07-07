require 'csv'
require 'open-uri'
require 'nokogiri'

class GunplaController < ApplicationController

  def index
	@gunplas = Gunpla.all
	@page_title = "Elenco Gundam"
	respond_to do |format|
		format.html # index.html.erb
		format.js
	end
  end
  
  def cosmicimport
	@page_title = "Importazione da cosmic"
	cosmicCsvImport
  end
  
  def show
	@gunpla = Gunpla.find(params[:id])
	@page_title = @gunpla.codiceProdotto + @gunpla.descrizioneCosmic
  end
  
  def importHljData 
		@gunpla = Gunpla.find(params[:id])
		baseUrl = "http://wholesale.hlj.com/vendors/backend/wholesale_worksheet/scripts/handler/lookup?reqItemCode=CODE&custId=172599"
		baseUrl["CODE"]= @gunpla.codiceHlj
		url = baseUrl
		doc = open(url).read
		docJson = JSON.parse(doc)
		puts docJson.inspect
		@gunpla.descrizioneHlj = docJson['itemName']
		@gunpla.janCode = docJson['janCode']
		@gunpla.save
		@status = "Importazione avvenuta con successo"
		puts '\e[1m\e[31m prova'
		respond_to do |format|
		    format.js  
			format.html 
		end
  end
  
  def import1999Data
		@gunpla = Gunpla.find(params[:id])
		baseUrl = "http://www.1999.co.jp/search_e.asp?Typ1_c=101&scope=0&scope2=0&itkey="
		
		if params[:q] != "" then
			url = baseUrl + params[:q]
		else 
			if @gunpla.janCode == nil then self.importHljData end
			url = baseUrl + @gunpla.janCode
		end
		doc = Nokogiri.HTML(open(url))
		n = 0
		doc.xpath('//a').each do |extract|
			tmpUrl = extract['href'][/\/eng\/\d+/]
		    if tmpUrl != nil then 
				@productUrl1999 = "http://www.1999.co.jp" + tmpUrl 
				n = n + 1
			end		
 		end
		
		
		if n > 2 then 
			@status = "Prodotto non univoco, impossibile importare"
		elsif n == 2 then
			doc = Nokogiri.HTML(open(@productUrl1999))
			contenuto = doc.xpath('//div[@class="right"]').first.content
			@categoria = contenuto[/Original.*/].gsub("Original:","").strip
			@series = contenuto[/Series.*/].gsub("Series:","").strip
			#puts contenuto[/Scale.*/]
			#puts contenuto[/Series.*/]
			#puts contenuto[/Original.*/]
			#n = 0
			#doc.xpath('//div[@class="right"]/table/tr/td/span[@class="imgbox"]/a/img').each do |extract|
			#	imageUrl = extract['src'].gsub("_s","")
			#	download(imageUrl, "images/" + @nomeProdotto + n.to_s + ".jpg")
			#	puts imageUrl
			#	n = n + 1
			#end
			@gunpla.codice1999 = @productUrl1999.gsub("http://www.1999.co.jp/eng/","")
			@gunpla.save
			@status = "Importazione da 1999 avvenuta con successo"
		else
			@status = "nessuna corrispondenza su 1999"
		end
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
