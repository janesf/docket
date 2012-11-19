class CaseinventorsController < ApplicationController
  # GET /caseinventors
  # GET /caseinventors.xml
  def index
    @caseinventors = Caseinventor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @caseinventors }
    end
  end

  # GET /caseinventors/1
  # GET /caseinventors/1.xml
  def show
    @caseinventor = Caseinventor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @caseinventor }
    end
  end

  # GET /caseinventors/new
  # GET /caseinventors/new.xml
  def new
    @caseinventor = Caseinventor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @caseinventor }
    end
  end

  # GET /caseinventors/1/edit
  def edit
    @caseinventor = Caseinventor.find(params[:id])
  end

  # POST /caseinventors
  # POST /caseinventors.xml
  def create
    @caseinventor = Caseinventor.new(params[:caseinventor])

    respond_to do |format|
      if @caseinventor.save
        flash[:notice] = 'Caseinventor was successfully created.'
        format.html { redirect_to(@caseinventor) }
        format.xml  { render :xml => @caseinventor, :status => :created, :location => @caseinventor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @caseinventor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /caseinventors/1
  # PUT /caseinventors/1.xml
  def update
    @caseinventor = Caseinventor.find(params[:id])

    respond_to do |format|
      if @caseinventor.update_attributes(params[:caseinventor])
        flash[:notice] = 'Caseinventor was successfully updated.'
        format.html { redirect_to(@caseinventor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @caseinventor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /caseinventors/1
  # DELETE /caseinventors/1.xml
  def destroy
    @caseinventor = Caseinventor.find(params[:id])
    @caseinventor.destroy

    respond_to do |format|
      format.html { redirect_to(caseinventors_url) }
      format.xml  { head :ok }
    end
  end
end
