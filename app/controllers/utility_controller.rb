class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplapg = Accessready.new.getproductstype("pg")
    tmp = render_to_string(:layout => false)
    puts tmp.encode("ISO-8859-15")
    Accessready.new.updategunplahome(tmp)
  end
end

