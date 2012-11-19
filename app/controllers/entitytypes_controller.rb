class EntitytypesController < ApplicationController

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
                  
  # GET /entitytypes
  # GET /entitytypes.xml
  def index
    @entitytypes = Entitytype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entitytypes }
    end
  end

  # GET /entitytypes/1
  # GET /entitytypes/1.xml
  def show
    @entitytype = Entitytype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entitytype }
    end
  end

  # GET /entitytypes/new
  # GET /entitytypes/new.xml
  def new
    @entitytype = Entitytype.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entitytype }
    end
  end

  # GET /entitytypes/1/edit
  def edit
    @entitytype = Entitytype.find(params[:id])
  end

  # POST /entitytypes
  # POST /entitytypes.xml
  def create
    @entitytype = Entitytype.new(params[:entitytype])

    respond_to do |format|
      if @entitytype.save
        flash[:notice] = 'Entitytype was successfully created.'
        format.html { redirect_to(@entitytype) }
        format.xml  { render :xml => @entitytype, :status => :created, :location => @entitytype }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entitytype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entitytypes/1
  # PUT /entitytypes/1.xml
  def update
    @entitytype = Entitytype.find(params[:id])

    respond_to do |format|
      if @entitytype.update_attributes(params[:entitytype])
        flash[:notice] = 'Entitytype was successfully updated.'
        format.html { redirect_to(@entitytype) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entitytype.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entitytypes/1
  # DELETE /entitytypes/1.xml
  def destroy
    @entitytype = Entitytype.find(params[:id])
    @entitytype.destroy

    respond_to do |format|
      format.html { redirect_to(entitytypes_url) }
      format.xml  { head :ok }
    end
  end
end
