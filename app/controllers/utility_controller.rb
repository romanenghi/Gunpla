class UtilityController < ApplicationController
  def index
   @page_title = "Utility"
   @foto = Accessready.new.getimages("QUE57015","8")
  end
  
  def gunplahome
   @gunplahg = Accessready.new.gethg
  end
end
