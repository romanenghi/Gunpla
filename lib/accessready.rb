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

  def getproductstype(type)
    case type
    when "pg"
      query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 41 AND IdLanguage = 1"
    when "mg"
      query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 25 AND IdLanguage = 1"
    when "hg"
      query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 39 AND IdLanguage = 1"
    else
    query = ""
    end

    unless query == ""
      open
      sth = @connection.prepare(query)
      sth.execute
      products = sth.fetch_all
      product_filtered = []
      close
      products.each do |product|
        categories = product[50].split
        categories.each do |category|
          if category == "98"
            product_filtered << product
            puts product[10]
          end
        end
      end
      product_filtered.sort_by!{|product| product[13]}
    return product_filtered
    end
  end

  def getimages(code, type)
      self.open
      query = "SELECT `Articoli`.`ID articolo`, `Articoli`.`Descrizione`, `Articoli`.`Codice Articolo`, `FotoLinks`.`IdFoto`, `Foto`.`IdTipoFoto`, `Foto`.`Nomefile` FROM `FotoLinks`, `Articoli`, `Foto` WHERE `FotoLinks`.`IdArticolo` = `Articoli`.`ID articolo` AND `Foto`.`ID` = `FotoLinks`.`IdFoto` AND `Articoli`.`Codice Articolo` = '#{code}' AND `Foto`.`IdTipoFoto` = #{type}"
      sth = @connection.prepare(query)
      sth.execute
      images = sth.fetch_all
      self.close
      puts images
      return images
  end
end
