require 'RMagick'

class Imagetool
    attr_accessor :img

    def initialize
        @img = nil
    end
    
    def getimage(uri)
      @img = Magick::ImageList.new(uri)
    end
    
    def crop(a, b, c, d)
      @img = @img.crop(a,b,c,d)
    end
    
    def save(file_name)
      @img.write(file_name)  
    end
    
    def addlogo
      logo = Magick::ImageList.new('public\images\logo.png')
      logo = logo.resize_to_fit(@img.columns, @img.rows)
      @img = @img.composite(logo, 0, 0, Magick::OverCompositeOp)
    end
    
end