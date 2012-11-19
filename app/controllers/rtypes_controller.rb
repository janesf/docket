class RtypesController < ApplicationController
  # GET /rtypes
  # GET /rtypes.xml
  def index
    @rtypes = Rtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rtypes }
    end
  end

  # GET /rtypes/1
  # GET /rtypes/1.xml
  def show
    @rtype = Rtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rtype }
    end
  end

  # GET /rtypes/new
  # GET /rtypes/new.xml
  def new
    @rtype = Rtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rtype }
    end
  end

  # GET /rtypes/1/edit
  def edit
    @rtype = Rtype.find(params[:id])
  end

  # POST /rtypes
  # POST /rtypes.xml
  def create
    @rtype = Rtype.new(params[:rtype])

    respond_to do |format|
      if @rtype.save
        flash[:notice] = 'Rtype was successfully created.'
        format.html { redirect_to(@rtype) }
        format.xml  { render :xml => @rtype, :status => :created, :location => @rtype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rtypes/1
  # PUT /rtypes/1.xml
  def update
    @rtype = Rtype.find(params[:id])

    respond_to do |format|
      if @rtype.update_attributes(params[:rtype])
        flash[:notice] = 'Rtype was successfully updated.'
        format.html { redirect_to(@rtype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rtype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rtypes/1
  # DELETE /rtypes/1.xml
  def destroy
    @rtype = Rtype.find(params[:id])
    @rtype.destroy

    respond_to do |format|
      format.html { redirect_to(rtypes_url) }
      format.xml  { head :ok }
    end
  end
end
