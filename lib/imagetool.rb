require 'RMagick'



class Imagetool
  attr_accessor :img, :status
  def initialize
    @img = nil
    @status = "ok"
  end

  def getimage(uri)
    begin
      @img = Magick::ImageList.new(uri)
    rescue Magick::ImageMagickError 
      @status = "errore"
    end

  end

  def crop(a, b, c, d)
    @img = @img.crop(a,b,c,d)
  end

  def save(file_name)
    @img.write(file_name)
  end
  
  def delete(file_name)
    if File.exist?(file_name)
      File.delete(file_name)
    else
      @status = "errore, impossibile trovare il file selezionato"
      puts @status
    end
  end

  def addlogo
    logo = Magick::ImageList.new('public\images\logo.png')
    logo = logo.resize_to_fit(@img.columns, @img.rows)
    @img = @img.composite(logo, 0, 0, Magick::OverCompositeOp)
  end

end