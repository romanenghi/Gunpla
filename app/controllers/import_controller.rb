class ImportController < ApplicationController
  def import
  end
  def upload
    @uploaded_io = params[:csv]
    File.open(Rails.root.join('public', 'uploads', @uploaded_io.original_filename), 'wb') do |file|
      file.write(@uploaded_io.read)
    end
    @arr_of_arrs = CSV.read(Rails.root.join('public', 'uploads', @uploaded_io.original_filename))
    @importoption = Importoption.all
  end
  def parse
  end
  def cosmicCsvImport
    CSV.foreach("files/gunpla.csv") do |row|
      if row[0].to_f.to_s != "0.0" then
        tmp = Datacosmic.where("code = ?",row[0]).first
        if tmp == nil then datacosmic = Datacosmic.new
        else datacosmic = tmp
        end
        datacosmic.code = row[0].strip # Seleziona la colonna n. 0, corrispondente al codice cosmic
        datacosmic.description = row[2].strip # Seleziona la colonna n. 2, corrispondente alla descrizione secondo cosmic
        datacosmic.jancode = row[3].strip # Importa il cosmic Jan Code
        datacosmic.publicprice = row[5].gsub(",",".").to_f #Importa il prezzo al pubblico consigliato da cosmic
        gunplacode = cosmicToHlj(datacosmic.jancode)
        if Gunpla.where("code = ?",gunplacode).count == 0  #se non esiste il gunpla corrispondente lo crea 
          gunpla = Gunpla.new
        gunpla.code = gunplacode
        #associa come descrizione e prezzo di default quelli del file di cosmic
        gunpla.description = datacosmic.description
        gunpla.publicprice = datacosmic.publicprice
        gunpla.datacosmic = datacosmic
        gunpla.save
        else
          gunpla = Gunpla.where("code = ?",gunplacode).first #se esiste il gunpla. ci associa i dati di cosmic
        gunpla.datacosmic = datacosmic
        #aggiorna in ogni caso i prezzi
        gunpla.datacosmic.publicprice = row[5].gsub(",",".").to_f
        gunpla.publicprice = datacosmic.publicprice
        gunpla.save
        end
      end
    end
  end
  
end
