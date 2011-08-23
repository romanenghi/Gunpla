class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplapg = Accessready.new.getproductstype("pg")
    @gunplahg = Accessready.new.getproductstype("hg")
    @gunplamg = Accessready.new.getproductstype("mg")
    @gunplahgaw = Accessready.new.getproductstype("hgaw")
    @gunplahgfc = Accessready.new.getproductstype("hgfc")
    @gunplarg = Accessready.new.getproductstype("rg")
    @gunplatool = Accessready.new.getproductstype("tool")
  end
end

