class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplapg = Accessready.new.getproductstype("pg")
    Accessready.new.updategunplahome(render_to_string(:layout => false).encode('utf-8'))
  end
end

