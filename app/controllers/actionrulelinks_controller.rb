class ActionrulelinksController < ApplicationController
  # GET /actionrulelinks
  # GET /actionrulelinks.xml
  def index
    @actionrulelinks = Actionrulelink.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actionrulelinks }
    end
  end

  # GET /actionrulelinks/1
  # GET /actionrulelinks/1.xml
  def show
    @actionrulelink = Actionrulelink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @actionrulelink }
    end
  end

  # GET /actionrulelinks/new
  # GET /actionrulelinks/new.xml
  def new
    @actionrulelink = Actionrulelink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @actionrulelink }
    end
  end

  # GET /actionrulelinks/1/edit
  def edit
    @actionrulelink = Actionrulelink.find(params[:id])
  end

  # POST /actionrulelinks
  # POST /actionrulelinks.xml
  def create
    @actionrulelink = Actionrulelink.new(params[:actionrulelink])

    respond_to do |format|
      if @actionrulelink.save
        flash[:notice] = 'Actionrulelink was successfully created.'
        format.html { redirect_to(@actionrulelink) }
        format.xml  { render :xml => @actionrulelink, :status => :created, :location => @actionrulelink }
      else
        format.html { render :aaction => "new" }
        format.xml  { render :xml => @actionrulelink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /actionrulelinks/1
  # PUT /actionrulelinks/1.xml
  def update
    @actionrulelink = Actionrulelink.find(params[:id])

    respond_to do |format|
      if @actionrulelink.update_attributes(params[:actionrulelink])
        flash[:notice] = 'Actionrulelink was successfully updated.'
        format.html { redirect_to(@actionrulelink) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @actionrulelink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /actionrulelinks/1
  # DELETE /actionrulelinks/1.xml
  def destroy
    @actionrulelink = Actionrulelink.find(params[:id])
    @actionrulelink.destroy

    respond_to do |format|
      format.html { redirect_to(actionrulelinks_url) }
      format.xml  { head :ok }
    end
  end
end
