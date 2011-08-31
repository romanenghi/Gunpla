require 'htmlentities'

class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplapg = Accessready.new.getproductstype("pg")
    tmp = render_to_string(:layout => false)
    aFile = File.new("myString.txt", "w")
    aFile.write(tmp)
    aFile.close
    Accessready.new.updategunplahome(File.new("myString.txt", "r").read)
  end
end

