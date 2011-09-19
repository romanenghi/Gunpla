require 'csv'
require 'open-uri'
require 'nokogiri'



class GunplasController < ApplicationController
  def index
    @gunplas = Gunpla.find(:all, :include => [:images, :categories, :gunplascala, :datacosmic, :gunplamodeltype])
    
    @page_title = "Elenco Gundam"
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def export
    @gunplas = Gunpla.where("export = ?", true)
    respond_to do |format|
      format.html # export.html.erb
      format.js
    end
  end

  def exportCVS
    @page_title = "Esportazione"
    @gunplas = Gunpla.where("export = ?", true)
    #@gunplas = Gunpla.all
    CSV.open("file.csv", "wb") do |csv|
      @gunplas.each do |gunpla|
        base = 'C:/script/gunpla/Gunpla/public/images/'
        csv << [gunpla.code,
          gunpla.description,
          gunpla.longdescription,
          gunpla.publicprice,
          gunpla.publicprice,
          gunpla.datacosmic.code,
          gunpla.jancode,
          gunpla.categories.first.codiceready,
          "100"
          #base + gunpla.images.first.localpath,
          #base + gunpla.images.first.localpath
        ]
      end
    end

    respond_to do |format|
      format.html # export.html.erb
      format.js
    end
  end

  def new
    @gunpla = Gunpla.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gunpla }
    end
  end

  def create
    @gunpla = Gunpla.new(params[:gunpla])

    respond_to do |format|
      if @gunpla.save
        format.html { redirect_to @gunpla, notice: 'Gunpla was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @gunpla = Gunpla.find(params[:id])
    respond_to do |format|
      if @gunpla.update_attributes(params[:gunpla])
        format.html { redirect_to(@gunpla, notice: 'Gunpla was successfully updated.') }
      else
        format.html { redirect_to(@gunpla, notice: 'Impossibile aggiornare.') }
      end
    end
  end

  def destroy
    @gunpla = Gunpla.find(params[:id])
    @gunpla.destroy

    respond_to do |format|
      format.html { redirect_to(gunplas_url) }
      format.xml  { head :ok }
    end
  end

  def cosmicimport
    @page_title = "Importazione da cosmic"
    cosmicCsvImport
  end

  def show
    @gunpla = Gunpla.find(params[:id])
    @datacosmic = @gunpla.datacosmic
    @page_title = @gunpla.code
  end

  def importReady
    @gunpla = Gunpla.find(params[:id])
    @readyproduct = Accessready.new.getproduct(@gunpla.code)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def importHljData
    @gunpla = Gunpla.find(params[:gunplaid])
    baseUrl = "http://wholesale.hlj.com/vendors/backend/wholesale_worksheet/scripts/handler/lookup?reqItemCode=CODE&custId=172599"
    baseUrl["CODE"]= params[:code]
    url = baseUrl
    doc = open(url).read
    docJson = JSON.parse(doc)

    if docJson['status'] == "OK" then
      @datahlj = Datahlj.new
      puts docJson.inspect
      @datahlj.code = docJson['itemCode']
      @datahlj.description = docJson['itemName']
      @datahlj.jancode = docJson['janCode']

      doc = Nokogiri.HTML(open("http://www.hlj.com/product/#{@datahlj.code}"))

      image = doc.xpath('//div[@id="inner-content"]/table/tr/td/img').first['style'][/'.*'/]
      (image == nil) ? (@datahlj.image = "non disponibile") : (@datahlj.image = image[1..-2])

      longdescription = doc.xpath('//div[@class="productdescr"]').first
      (longdescription == nil) ? (@datahlj.longdescription = "non disponibile") : (@datahlj.longdescription = longdescription.content)

      productseriestitle = doc.xpath('//a[@class="productseriestitle"]').first
      (productseriestitle == nil) ? (@datahlj.productseriestitle = "non disponibile") : (@datahlj.productseriestitle = productseriestitle.content)

      producttype = doc.xpath('//a[@class="current"]').first
      (producttype == nil) ? (@datahlj.producttype = "non disponibile") : (@datahlj.producttype = producttype.content)
 
      @gunpla.datahlj = @datahlj
      @gunpla.save
      @status = "Importazione avvenuta con successo"
    else
      @status = "Impossibile trovare questo prodotto su HLJ"
    end

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
        datacosmic.publicprice = row[5][/\d*,\d*/].to_f #Importa il prezzo al pubblico consigliato da cosmic
        gunplacode = cosmicToHlj(datacosmic.jancode)
        if Gunpla.where("code = ?",gunplacode).count == 0  #se non esiste il gunpla corrispondente lo crea 
          gunpla = Gunpla.new
        gunpla.code = gunplacode
        #associa come descrizione e prezzo di default quelli del file di cosmic
        gunpla.description = datacosmic.description
        gunpla.publicprice = datacosmic.publicprice
        gunpla.datacosmic = datacosmic
        gunpla.save
        else
          gunpla = Gunpla.where("code = ?",gunplacode).first #se esiste il gunpla. ci associa i dati di cosmic
        gunpla.datacosmic = datacosmic
        #aggiorna in ogni caso i prezzi
        gunpla.datacosmic.publicprice = row[5][/\d*,\d*/].to_f
        gunpla.publicprice = datacosmic.publicprice
        gunpla.save
        end
      end
    end
  end

  def cosmicToHlj(cosmicCode)
    
    if cosmicCode.length == 7
      suffix = cosmicCode[0,2]
      result = case suffix
      when "01" then "BAN9" + cosmicCode[2..cosmicCode.length]
      when "00" then "BAN" + cosmicCode[2..cosmicCode.length]
      else "Invalid#{cosmicCode}"
      end
    elsif cosmicCode.length == 6
      suffix = cosmicCode[0,1]
      result = case suffix
      when "1" then "BAN9" + cosmicCode[1..cosmicCode.length]
      else "Invalid#{cosmicCode}"
      end
    else
      result = "Invalid#{cosmicCode}"
    end
    return result
  end

  def getnewimage
    @gunpla = Gunpla.find(params[:gunplaid])
    @image = Image.new
    @image.gunpla_id = params[:gunplaid]
    @image.remotepath = (params[:url])
    @image.name = "#{@gunpla.code}_#{@gunpla.images.length+1}.jpg"
    @image.localpath = "public/images/#{@image.name}"
    @img=Imagetool.new
    @img.getimage(params[:url])
    respond_to do |format|
      if @img.status == "ok"
        @image.save
        @img.save(@image.localpath)
        format.html { redirect_to @gunpla, notice: 'Immagine aggiunta con successo' }
      else
        format.html { redirect_to @gunpla, notice: 'Errore' }
      end
    end
  end

  def deleteimage
    @gunpla = Gunpla.find(params[:gunplaid])
    @image = Image.find(params[:imageid])
    @img = Imagetool.new
    @img.delete(@image.localpath)
    @image.destroy
    respond_to do |format|
      if @img.status == "ok"
        format.html { redirect_to @gunpla, notice: 'Immagine elimitana con successo' }
      else
        format.html { redirect_to @gunpla, notice: @img.status }
      end
    end
  end

  def categories
    @page_title = "Gestione categorie"
    @categories = Category.find(:all)
  end

  def getcategories
    @readycategories = Accessready.new.getcategories
    @readycategories.each do |readycategory|
      category = Category.where("codiceready = ?", readycategory[4]).first
      if category == nil then category = Category.new end
      category.name = readycategory[2]
      category.codiceready = readycategory[4]
      category.save
    end

    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'Categorie importate con successo' }
    end
  end
 
 def gunplascalas
    @page_title = "Gestione scale"
    @gunplascalas = Gunplascala.find(:all)
  end

  def getgunplascalas
    @readyscalas = Accessready.new.getgunplascalas
    @readyscalas.each do |readyscala|
      scala = Gunplascala.where("codiceready = ?", readyscala[0]).first
      if scala == nil then scala = Gunplascala.new end
      scala.name = readyscala[1]
      scala.codiceready = readyscala[0]
      scala.save
    end

    respond_to do |format|
      format.html { redirect_to gunplascalas_path, notice: 'Elenco "scale" importate con successo' }
    end
  end
 
 def gunplamodeltypes
    @page_title = "Gestione tipologie"
    @gunplamodeltypes = Gunplamodeltype.find(:all)
  end

  def getgunplamodeltypes
    @readytypes = Accessready.new.getgunplamodeltypes
    @readytypes.each do |readytype|
      type = Gunplamodeltype.where("codiceready = ?", readytype[0]).first
      if type == nil then type = Gunplamodeltype.new end
      type.name = readytype[1]
      type.codiceready = readytype[0]
      type.save
    end

    respond_to do |format|
      format.html { redirect_to gunplamodeltypes_path, notice: 'Elenco "tipologie" importate con successo' }
    end
  end

  def googleimage
    searchstring = URI.encode_www_form_component(params[:query])
    page = params[:page]
    start = page * 18
    if searchstring != ""
      @doc = Nokogiri.HTML(open("http://www.google.com/search?q=#{searchstring}&hl=it&sa=G&biw=1262&bih=621&gbv=2&tbm=isch&sout=1&start=#{start}"))
      @results = @doc.xpath('//ol/div/table/tr/td/a/@href')
    end
    @results.each do |result|
      puts (URI.extract(result.content)).first.scan(/.*jpg/)
    end
  end

end

