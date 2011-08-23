require 'odbc'



class Accessready
  attr_accessor :dns, :connection, :data, :fields, :categories
  def initialize(dns=nil)
    @dns = "Prova"
    @connection = nil
    @data = nil
    @fields = nil
  end

  def open
    @connection = ODBC.connect(dns)
  end

  def close
    if @connection  then @connection.disconnect end
  end

  def getproduct (code)
    if @connection == nil then self.open end
    sth = @connection.prepare ("SELECT * FROM Articoli WHERE [Codice Articolo] = '#{code}'")
    sth.execute
    product = sth.fetch
    self.close
    return product
  end

  def getcategories
    if @connection == nil then self.open end
    sth = @connection.prepare ("SELECT * FROM [Articoli categorie] WHERE CodiceAlternativo <> '' ")
    sth.execute
    @categories = sth.fetch_all
    self.close
    return @categories
  end

  # Recupera dal database tutti i prodotti corrispondenti a un certo tipo (type), opzionalmente
  # con l'immagine di anteprima (bool miniatures)
  def getproductstype(type)
    case type
    when "pg"
      idtype = 41 
    when "mg"
      idtype = 25 
    when "hg"
      idtype = 39 
    when "hgaw"
      idtype = 79
    when "hgfc"
      idtype = 80
    when "rg"
      idtype = 78
    else
    idtype = nil
    end

    unless idtype == nil
      query = "SELECT `WebOggetti`.`ProdCode`, `WebOggetti`.`Description`, `WebOggetti`.`CategoryDesc`, `WebOggetti`.`CustomT2Desc`, `WebOggetti`.`IdProduct`, `WebOggetti`.`CustomT2ID`, `WebOggetti`.`ProductCategoriesAndFathers`, `Foto`.`IdTipoFoto`, `Foto`.`Nomefile`, `WebOggetti`.`QTotMagazzino`, `WebOggetti`.`PrezzoListinoUfficiale`, `WebOggetti`.`IdLanguage` FROM `WebOggetti`, `FotoLinks`, `Foto` WHERE `WebOggetti`.`IdProduct` = `FotoLinks`.`IdArticolo` AND `Foto`.`ID` = `FotoLinks`.`IdFoto` AND `WebOggetti`.`CustomT2ID` = #{idtype} AND `Foto`.`IdTipoFoto` = 1 AND `WebOggetti`.`IdLanguage` = 1 ORDER BY `WebOggetti`.`CategoryDesc` DESC"
      open
      sth = @connection.prepare(query)
      sth.execute
      products = sth.fetch_all
      gunplas = []
      close
      if products == nil
      return gunplas
      else
        products.each do |product|
          categories = product[6].split
          categories.each do |category|
            if category == "98"
              gunpla = {'codice' => product[0],
                'descrizione' => product[1],
                'categoria' => product[2],
                'tipologia' => product[3],
                'thumb' => product[8],
                'quantita' => product[9],
                'prezzo' => product[10]}
            gunplas << gunpla
            end
          end
        end
      return gunplas
      end
    end
  end

  def getimages(code, type)
    self.open
    query = "SELECT `Articoli`.`ID articolo`, `Articoli`.`Descrizione`, `Articoli`.`Codice Articolo`, `FotoLinks`.`IdFoto`, `Foto`.`IdTipoFoto`, `Foto`.`Nomefile` FROM `FotoLinks`, `Articoli`, `Foto` WHERE `FotoLinks`.`IdArticolo` = `Articoli`.`ID articolo` AND `Foto`.`ID` = `FotoLinks`.`IdFoto` AND `Articoli`.`Codice Articolo` = '#{code}' AND `Foto`.`IdTipoFoto` = #{type}"
    sth = @connection.prepare(query)
    sth.execute
    images = sth.fetch_all
    self.close
    return images
  end
end
