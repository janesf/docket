class RstatusesController < ApplicationController
  # GET /rstatuses
  # GET /rstatuses.xml
  def index
    @rstatuses = Rstatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rstatuses }
    end
  end

  # GET /rstatuses/1
  # GET /rstatuses/1.xml
  def show
    @rstatus = Rstatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rstatus }
    end
  end

  # GET /rstatuses/new
  # GET /rstatuses/new.xml
  def new
    @rstatus = Rstatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rstatus }
    end
  end

  # GET /rstatuses/1/edit
  def edit
    @rstatus = Rstatus.find(params[:id])
  end

  # POST /rstatuses
  # POST /rstatuses.xml
  def create
    @rstatus = Rstatus.new(params[:rstatus])

    respond_to do |format|
      if @rstatus.save
        flash[:notice] = 'Rstatus was successfully created.'
        format.html { redirect_to(@rstatus) }
        format.xml  { render :xml => @rstatus, :status => :created, :location => @rstatus }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rstatus.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rstatuses/1
  # PUT /rstatuses/1.xml
  def update
    @rstatus = Rstatus.find(params[:id])

    respond_to do |format|
      if @rstatus.update_attributes(params[:rstatus])
        flash[:notice] = 'Rstatus was successfully updated.'
        format.html { redirect_to(@rstatus) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rstatus.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rstatuses/1
  # DELETE /rstatuses/1.xml
  def destroy
    @rstatus = Rstatus.find(params[:id])
    @rstatus.destroy

    respond_to do |format|
      format.html { redirect_to(rstatuses_url) }
      format.xml  { head :ok }
    end
  end
end
