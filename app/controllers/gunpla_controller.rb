require 'csv'
require 'open-uri'
require 'nokogiri'
require 'accessdb'
require 'win32ole'
class GunplaController < ApplicationController

  def index
	@gunplas = Gunpla.all
	@page_title = "Elenco Gundam"
	respond_to do |format|
		format.html # index.html.erb
		format.js
	  end
  end
  
 def update
  @gunpla = Gunpla.find(params[:id])
  respond_to do |format|
    if @gunpla.update_attributes(params[:gunpla])
      format.html { redirect_to(@gunpla, :notice => 'Gunpla was successfully updated.') }
    else
      format.html { render :action => "edit" }

    end
  end
end

  def cosmicimport
	@page_title = "Importazione da cosmic"
	cosmicCsvImport
  end
  
  def show
	@gunpla = Gunpla.find(params[:id])
	@page_title = @gunpla.code
  end 
  
  def ready
    @page_title = "Ready pro"
    if params[:string] != nil then
      db = AccessDb.new('C:\script\ready\Ready_backup.RDB')
      db.open
      query = "SELECT * FROM Articoli WHERE Descrizione LIKE '#{params[:string]}%'"
      db.query(query)
      @field_names = db.fields
      @rows = db.data
      puts query
      db.close
    end
  end

  def importReady
    @gunpla = Gunpla.find(params[:id])
    db = AccessDb.new('C:\script\ready\Ready_backup.RDB')
      db.open
      query = "SELECT * FROM Articoli WHERE 'Codice Articolo' = '#{@gunpla.code}%'"
      db.query(query)
      @field_names = db.fields
      @rows = db.data
      puts query
    db.close
    respond_to do |format|
      format.js 
      format.html 
    end
  end
  
  def importHljData 
		@gunpla = Gunpla.find(params[:id])
		tmp = Datahlj.where("code = ?",@gunpla.code).first 
        if tmp == nil then datahlj = Datahlj.new 
          else datahlj = tmp
        end
		baseUrl = "http://wholesale.hlj.com/vendors/backend/wholesale_worksheet/scripts/handler/lookup?reqItemCode=CODE&custId=172599"
		baseUrl["CODE"]= @gunpla.code
		url = baseUrl
		doc = open(url).read
		docJson = JSON.parse(doc)
		datahlj.code = @gunpla.code
		datahlj.description = docJson['itemName']
		datahlj.jancode = docJson['janCode']
		@gunpla.datahlj = datahlj
	  @gunpla.save
	  @status = "Importazione avvenuta con successo"
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
        tmp = Datacosmic.where("code = ?",row[0]).first 
        if tmp == nil then datacosmic = Datacosmic.new 
          else datacosmic = tmp
        end
		    datacosmic.code = row[0].strip # Seleziona la colonna n. 0, corrispondente al codice cosmic
	   	  datacosmic.description = row[2].strip # Seleziona la colonna n. 2, corrispondente alla descrizione secondo cosmic
	   	  datacosmic.jancode = row[3].strip # Importa il cosmic Jan Code
	      datacosmic.publicprice = row[5].strip #Importa il prezzo al pubblico consigliato da cosmic
	   	  
	   	  gunplacode = cosmicToHlj(datacosmic.jancode)
	      if Gunpla.where("code = ?",gunplacode).count == 0  #se non esiste il gunpla corrispondente lo crea
	          gunpla = Gunpla.new
	          gunpla.code = gunplacode
	          gunpla.datacosmic = datacosmic
	          gunpla.save
  	    else
	          gunpla = Gunpla.where("code = ?",gunplacode).first #se esiste il gunpla. ci associa i dati di cosmic 
		        gunpla.datacosmic = datacosmic
		        gunpla.save
		    end 
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

