class CountrycodesController < ApplicationController

   before_filter  :check_read_access
   before_filter  :check_write_access, :only => [:new, :edit, :create, :update, :destroy]
   
   def check_read_access
      unless current_user.role.data_read == true then
         flash[:notice]='Access denied.'
         if request.env['HTTP_REFERER'].nil? then
            redirect_to :controller => :admin, :action => :login
         else
            redirect_to :back
         end
      end
   end
                  
   def check_write_access
      unless current_user.role.data_write == true then
         flash[:notice]='Access denied.'
         if request.env['HTTP_REFERER'].nil? then
            redirect_to :controller => :admin, :action => :login
         else
            redirect_to :back
         end
      end
   end
                  
  # GET /countrycodes
  # GET /countrycodes.xml
  def index
    @countrycodes = Countrycode.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countrycodes }
    end
  end

  # GET /countrycodes/1
  # GET /countrycodes/1.xml
  def show
    @countrycode = Countrycode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @countrycode }
    end
  end

  # GET /countrycodes/new
  # GET /countrycodes/new.xml
  def new
    @countrycode = Countrycode.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @countrycode }
    end
  end

  # GET /countrycodes/1/edit
  def edit
    @countrycode = Countrycode.find(params[:id])
  end

  # POST /countrycodes
  # POST /countrycodes.xml
  def create
    @countrycode = Countrycode.new(params[:countrycode])

    respond_to do |format|
      if @countrycode.save
        flash[:notice] = 'Countrycode was successfully created.'
        format.html { redirect_to(@countrycode) }
        format.xml  { render :xml => @countrycode, :status => :created, :location => @countrycode }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @countrycode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countrycodes/1
  # PUT /countrycodes/1.xml
  def update
    @countrycode = Countrycode.find(params[:id])

    respond_to do |format|
      if @countrycode.update_attributes(params[:countrycode])
        flash[:notice] = 'Countrycode was successfully updated.'
        format.html { redirect_to(@countrycode) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @countrycode.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /countrycodes/1
  # DELETE /countrycodes/1.xml
  def destroy
    @countrycode = Countrycode.find(params[:id])
    @countrycode.destroy

    respond_to do |format|
      format.html { redirect_to(countrycodes_url) }
      format.xml  { head :ok }
    end
  end
end
