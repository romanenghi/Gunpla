class GunplatypesController < ApplicationController
  # GET /gunplatypes
  # GET /gunplatypes.xml
  def index
    @gunplatypes = Gunplatype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gunplatypes }
    end
  end

  # GET /gunplatypes/1
  # GET /gunplatypes/1.xml
  def show
    @gunplatype = Gunplatype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gunplatype }
    end
  end

  # GET /gunplatypes/new
  # GET /gunplatypes/new.xml
  def new
    @gunplatype = Gunplatype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gunplatype }
    end
  end

  # GET /gunplatypes/1/edit
  def edit
    @gunplatype = Gunplatype.find(params[:id])
  end

  # POST /gunplatypes
  # POST /gunplatypes.xml
  def create
    @gunplatype = Gunplatype.new(params[:gunplatype])

    respond_to do |format|
      if @gunplatype.save
        format.html { redirect_to(@gunplatype, :notice => 'Gunplatype was successfully created.') }
        format.xml  { render :xml => @gunplatype, :status => :created, :location => @gunplatype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gunplatype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gunplatypes/1
  # PUT /gunplatypes/1.xml
  def update
    @gunplatype = Gunplatype.find(params[:id])

    respond_to do |format|
      if @gunplatype.update_attributes(params[:gunplatype])
        format.html { redirect_to(@gunplatype, :notice => 'Gunplatype was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gunplatype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gunplatypes/1
  # DELETE /gunplatypes/1.xml
  def destroy
    @gunplatype = Gunplatype.find(params[:id])
    @gunplatype.destroy

    respond_to do |format|
      format.html { redirect_to(gunplatypes_url) }
      format.xml  { head :ok }
    end
  end
end
