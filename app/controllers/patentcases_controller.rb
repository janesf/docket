class PatentcasesController < ApplicationController

  # before_filter  :check_read_access
 #  before_filter  :check_write_access, :only => [:new, :edit, :create, :update, :destroy]
 before_filter :signed_in_user, only: [:create, :destroy]

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
                  
  # GET /patentcases
  # GET /patentcases.xml
  def index
   # @patentcases = Patentcase.find_by_sql( [ "select distinct p.* from patentcases p, usercases u where p.id = u.patentcase_id and user_id =(?) order by attorneydocket asc", current_user.id ] )
     @patentcases = current_user.patentcases
  #  session[:patentcase] = nil

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patentcases }
    end
  end

  # GET /patentcases/1
  # GET /patentcases/1.xml
  def show
    @patentcase = Patentcase.find(params[:id])
    session[:patentcase] = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patentcase }
    end
  end

  # GET /patentcases/new
  # GET /patentcases/new.xml
  def new
    @patentcase = Patentcase.new
  #  session[:patentcase] = params[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patentcase }
    end
  end

  def edit
    @patentcase = Patentcase.find(params[:id])
    #session[:patentcase] = params[:id]
  end

  # POST /patentcases
  # POST /patentcases.xml
  def create
    @patentcase = Patentcase.new(params[:patentcase])

    respond_to do |format|
      if @patentcase.save
        u = Usercase.new
        u.patentcase_id = @patentcase.id
        u.user_id = session[:user_id]
        u.save
        session[:patentcase] = @patentcase.id
        flash[:notice] = 'Patentcase was successfully created.'
        format.html { redirect_to(@patentcase) }
        format.xml  { render :xml => @patentcase, :status => :created, :location => @patentcase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patentcase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patentcases/1
  # PUT /patentcases/1.xml
  def update
    @patentcase = Patentcase.find(params[:id])
    session[:patentcase] = @patentcase.id

    respond_to do |format|
      if @patentcase.update_attributes(params[:patentcase])
       
        flash[:notice] = 'Patentcase was successfully updated.'
        format.html { redirect_to(@patentcase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patentcase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patentcases/1
  # DELETE /patentcases/1.xml
  def destroy
    @patentcase = Patentcase.find(params[:id])
    @patentcase.destroy
    session[:patentcase] = nil

    respond_to do |format|
      format.html { redirect_to(patentcases_url) }
      format.xml  { head :ok }
    end
  end
end
