# encoding: utf-8

require 'htmlentities'

class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplatypes = Gunplatype.all
    n = 0
    @gunplatypedescription = []
    @gunplatypelist = []

    @gunplatypes.each do |gunplatype|
      @gunplatypelist[n] = Accessready.new.getproductstype(gunplatype.codiceinterno)
      @gunplatypedescription[n] = {"title" => gunplatype.name,
                                   "image" => gunplatype.image,
                                   "description" => HTMLEntities.new.encode(gunplatype.description, :named)}
      n=n+1
    end
    Accessready.new.updategunplahome(render_to_string(:layout => false))
  end
end

