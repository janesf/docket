class RefdttypesController < ApplicationController

   before_filter  :check_read_access
   before_filter  :check_write_access, :only => [:new, :edit, :create, :update, :destroy]
   
   def check_read_access
      unless current_user.role.system_readwrite == true then
         flash[:notice]='Access denied.'
         if request.env['HTTP_REFERER'].nil? then
            redirect_to :controller => :admin, :action => :login
         else
            redirect_to :back
         end
      end
   end
                  
   def check_write_access
      unless current_user.role.system_readwrite == true then
         flash[:notice]='Access denied.'
         if request.env['HTTP_REFERER'].nil? then
            redirect_to :controller => :admin, :action => :login
         else
            redirect_to :back
         end
      end
   end
                  
  # GET /refdttypes
  # GET /refdttypes.xml
  def index
    @refdttypes = Refdttype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @refdttypes }
    end
  end

  # GET /refdttypes/1
  # GET /refdttypes/1.xml
  def show
    @refdttype = Refdttype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @refdttype }
    end
  end

  # GET /refdttypes/new
  # GET /refdttypes/new.xml
  def new
    @refdttype = Refdttype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @refdttype }
    end
  end

  # GET /refdttypes/1/edit
  def edit
    @refdttype = Refdttype.find(params[:id])
  end

  # POST /refdttypes
  # POST /refdttypes.xml
  def create
    @refdttype = Refdttype.new(params[:refdttype])

    respond_to do |format|
      if @refdttype.save
        flash[:notice] = 'Refdttype was successfully created.'
        format.html { redirect_to(@refdttype) }
        format.xml  { render :xml => @refdttype, :status => :created, :location => @refdttype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @refdttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /refdttypes/1
  # PUT /refdttypes/1.xml
  def update
    @refdttype = Refdttype.find(params[:id])

    respond_to do |format|
      if @refdttype.update_attributes(params[:refdttype])
        flash[:notice] = 'Refdttype was successfully updated.'
        format.html { redirect_to(@refdttype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @refdttype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /refdttypes/1
  # DELETE /refdttypes/1.xml
  def destroy
    @refdttype = Refdttype.find(params[:id])
    @refdttype.destroy

    respond_to do |format|
      format.html { redirect_to(refdttypes_url) }
      format.xml  { head :ok }
    end
  end
end
