class ImagetoolController < ApplicationController
  
  
  
  def crop
    @action = params[:commit]
 
    if @action == 'Crop' then
      @img=Imagetool.new
      @img.getimage('public\images\tmp\tmp.jpg')
      @img.crop(params[:x].to_i,params[:y].to_i,params[:w].to_i,params[:h].to_i)
      if params[:logo] then
        @img.addlogo
      end
      @img.save('public\images\tmp\tmpcrop.jpg')
    end
    
    if @action == 'Carica' then
      @img=Imagetool.new
      @img.getimage(params[:uri])
      @img.save('public\images\tmp\tmp.jpg')
    end
  end
end
