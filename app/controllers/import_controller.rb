class ImportController < ApplicationController
  @uploaded_io = nil
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
    @parametri = params[:importoption]
    CSV.foreach(Rails.root.join('public', 'uploads', @uploaded_io.original_filename)) do |row|
    
puts row.inspect
    end

  end

end
