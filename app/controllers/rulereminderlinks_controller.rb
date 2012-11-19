class RulereminderlinksController < ApplicationController
  # GET /rulereminderlinks
  # GET /rulereminderlinks.xml
  def index
    @rulereminderlinks = Rulereminderlink.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rulereminderlinks }
    end
  end

  # GET /rulereminderlinks/1
  # GET /rulereminderlinks/1.xml
  def show
    @rulereminderlink = Rulereminderlink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rulereminderlink }
    end
  end

  # GET /rulereminderlinks/new
  # GET /rulereminderlinks/new.xml
  def new
    @rulereminderlink = Rulereminderlink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rulereminderlink }
    end
  end

  # GET /rulereminderlinks/1/edit
  def edit
    @rulereminderlink = Rulereminderlink.find(params[:id])
  end

  # POST /rulereminderlinks
  # POST /rulereminderlinks.xml
  def create
    @rulereminderlink = Rulereminderlink.new(params[:rulereminderlink])

    respond_to do |format|
      if @rulereminderlink.save
        flash[:notice] = 'Rulereminderlink was successfully created.'
        format.html { redirect_to(@rulereminderlink) }
        format.xml  { render :xml => @rulereminderlink, :status => :created, :location => @rulereminderlink }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rulereminderlink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rulereminderlinks/1
  # PUT /rulereminderlinks/1.xml
  def update
    @rulereminderlink = Rulereminderlink.find(params[:id])

    respond_to do |format|
      if @rulereminderlink.update_attributes(params[:rulereminderlink])
        flash[:notice] = 'Rulereminderlink was successfully updated.'
        format.html { redirect_to(@rulereminderlink) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rulereminderlink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rulereminderlinks/1
  # DELETE /rulereminderlinks/1.xml
  def destroy
    @rulereminderlink = Rulereminderlink.find(params[:id])
    @rulereminderlink.destroy

    respond_to do |format|
      format.html { redirect_to(rulereminderlinks_url) }
      format.xml  { head :ok }
    end
  end
end
