class CasewatchingsController < ApplicationController
  # GET /casewatchings
  # GET /casewatchings.xml
  def index
    @casewatchings = Casewatching.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @casewatchings }
    end
  end

  # GET /casewatchings/1
  # GET /casewatchings/1.xml
  def show
    @casewatching = Casewatching.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @casewatching }
    end
  end

  # GET /casewatchings/new
  # GET /casewatchings/new.xml
  def new
    @casewatching = Casewatching.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @casewatching }
    end
  end

  # GET /casewatchings/1/edit
  def edit
    @casewatching = Casewatching.find(params[:id])
  end

  # POST /casewatchings
  # POST /casewatchings.xml
  def create
    @casewatching = Casewatching.new(params[:casewatching])

    respond_to do |format|
      if @casewatching.save
        flash[:notice] = 'Casewatching was successfully created.'
        format.html { redirect_to(@casewatching) }
        format.xml  { render :xml => @casewatching, :status => :created, :location => @casewatching }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @casewatching.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /casewatchings/1
  # PUT /casewatchings/1.xml
  def update
    @casewatching = Casewatching.find(params[:id])

    respond_to do |format|
      if @casewatching.update_attributes(params[:casewatching])
        flash[:notice] = 'Casewatching was successfully updated.'
        format.html { redirect_to(@casewatching) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @casewatching.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /casewatchings/1
  # DELETE /casewatchings/1.xml
  def destroy
    @casewatching = Casewatching.find(params[:id])
    @casewatching.destroy

    respond_to do |format|
      format.html { redirect_to(casewatchings_url) }
      format.xml  { head :ok }
    end
  end
end
