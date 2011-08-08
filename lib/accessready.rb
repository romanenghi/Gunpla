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
      puts product.inspect
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

 
end

tmp = Accessready.new
tmp.getcategories