class UtilityController < ApplicationController
  def index
    @page_title = "Utility"
    @foto = Accessready.new.getimages("QUE57015","8")
  end

  def gunplahome
    @gunplahg = Accessready.new.gethg
    @gunplahg.each do |gunpla|
      img = Accessready.new.getimages(gunpla[11],1)
      unless img == nil
        unless img.first == nil
          puts img.first
          gunpla << img.first[5]
        end
      end
    end
    @gunplamg = Accessready.new.getmg
    @gunplamg.each do |gunpla|
      img = Accessready.new.getimages(gunpla[11],1)
      unless img == nil
        unless img.first == nil
          puts img.first
          gunpla << img.first[5]
        end
      end
    end
    @gunplapg = Accessready.new.getpg
    @gunplapg.each do |gunpla|
      img = Accessready.new.getimages(gunpla[11],1)
      unless img == nil
        unless img.first == nil
          puts img.first
          gunpla << img.first[5]
        end
      end
    end
  end
end
