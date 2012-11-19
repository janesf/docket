class InventsController < ApplicationController
  # GET /invents
  # GET /invents.xml
  def index
    @invents = Invent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invents }
    end
  end

  # GET /invents/1
  # GET /invents/1.xml
  def show
    @invent = Invent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invent }
    end
  end

  # GET /invents/new
  # GET /invents/new.xml
  def new
    @invent = Invent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invent }
    end
  end

  # GET /invents/1/edit
  def edit
    @invent = Invent.find(params[:id])
  end

  # POST /invents
  # POST /invents.xml
  def create
    @invent = Invent.new(params[:invent])

    respond_to do |format|
      if @invent.save
        flash[:notice] = 'Invent was successfully created.'
        format.html { redirect_to(@invent) }
        format.xml  { render :xml => @invent, :status => :created, :location => @invent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invents/1
  # PUT /invents/1.xml
  def update
    @invent = Invent.find(params[:id])

    respond_to do |format|
      if @invent.update_attributes(params[:invent])
        flash[:notice] = 'Invent was successfully updated.'
        format.html { redirect_to(@invent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invents/1
  # DELETE /invents/1.xml
  def destroy
    @invent = Invent.find(params[:id])
    @invent.destroy

    respond_to do |format|
      format.html { redirect_to(invents_url) }
      format.xml  { head :ok }
    end
  end
end
