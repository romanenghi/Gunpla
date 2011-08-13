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

  def gethg
    open
    query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 39  AND IdLanguage = 1"
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
          puts product[11]
        end
      end
    end
    product_filtered.sort_by!{|product| product[13]}
    return product_filtered
  end
  
  def getmg
    open
    query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 25  AND IdLanguage = 1"
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
          puts product[11]
        end
      end
    end
    product_filtered.sort_by!{|product| product[13]}
    return product_filtered
  end
  
  def getpg
    open
    query = "SELECT * FROM [WebOggetti] WHERE [CustomT2ID] = 41 AND IdLanguage = 1"
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

  def getimages(code, type)
    product = getproduct(code)
    unless product == nil
      idproduct = product[0]
      self.open
      query = "SELECT * FROM FotoLinks WHERE IdArticolo = #{idproduct}"
      sth = @connection.prepare(query)
      sth.execute
      links= sth.fetch_all
      self.close
      if links != nil
        foto = []
        links.each do |link|
          self.open
          query = "SELECT * FROM [Foto] WHERE ID = #{link[2]} and IdTipoFoto = #{type}"
          sth = @connection.prepare (query)
          sth.execute
          results = sth.fetch_all
          unless results == nil
          foto << results.first
          end
          close
        end
      return foto
      end
    end
  end
end
