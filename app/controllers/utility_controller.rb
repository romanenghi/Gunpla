class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplapg = Accessready.new.getproductstype("pg")
    tmp = render_to_string(:layout => false)
    tmp2 = Iconv.iconv("ISO-8859-1//TRANSLIT","UTF-8",tmp)
    puts tmp2
    Accessready.new.updategunplahome(tmp2)
  end
end

