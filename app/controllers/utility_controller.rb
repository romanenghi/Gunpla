# encoding: utf-8

require 'htmlentities'
require 'open-uri'
require 'nokogiri'
require 'net/ftp'



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
      @gunplatypedescription[n] = {"title" => gunplatype.name.strip,
        "image" => gunplatype.image,
        "description" => HTMLEntities.new.encode(gunplatype.description, :named)}
      n=n+1
    end
    tmp = render_to_string
    doc = Nokogiri::HTML::Document.parse(tmp)
    # Save a string to a file.

    @gunplatypes.each do |gunplatype|
      html = doc.xpath("//*[@id='#{gunplatype.name.gsub(" ","").strip}']")
      aFile = File.new("#{gunplatype.name.gsub(" ","").strip}.html", "w")
      aFile.write(html)
      aFile.close
      ftp = Net::FTP.new('ftp.starshopbs.com')
      ftp.passive = true
      ftp.login("2039658@aruba.it", "n8uqrrrd")
      ftp.chdir('/starshopbs.com/public')
      ftp.putbinaryfile("#{gunplatype.name.gsub(" ","").strip}.html")
      ftp.close
    end

    html = doc.xpath("//*[@id='headergundamtype']")
    Accessready.new.updategunplahome(html.to_s)
  end
end

