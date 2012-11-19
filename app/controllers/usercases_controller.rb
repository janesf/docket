class UsercasesController < ApplicationController

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
                  
  # GET /usercases
  # GET /usercases.xml
  def index
    if session[:user_id] == 1 or session[:user_id] ==2
      @usercases = Usercase.find(:all, :order => :user_id)
    else
      @usercases = Usercase.find_by_sql(["select u.* from usercases u, users us where us.id = u.user_id and u.user_id = (?)", session[:user_id]])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usercases }
    end
  end

  # GET /usercases/1
  # GET /usercases/1.xml
  def show
    @usercase = Usercase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usercase }
    end
  end

  # GET /usercases/new
  # GET /usercases/new.xml
  def new
    @usercase = Usercase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usercase }
    end
  end

  # GET /usercases/1/edit
  def edit
    @usercase = Usercase.find(params[:id])
  end

  # POST /usercases
  # POST /usercases.xml
  def create
    @usercase = Usercase.new(params[:usercase])

    respond_to do |format|
      if @usercase.save
        flash[:notice] = 'Usercase was successfully created.'
        format.html { redirect_to(@usercase) }
        format.xml  { render :xml => @usercase, :status => :created, :location => @usercase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usercase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usercases/1
  # PUT /usercases/1.xml
  def update
    @usercase = Usercase.find(params[:id])

    respond_to do |format|
      if @usercase.update_attributes(params[:usercase])
        flash[:notice] = 'Usercase was successfully updated.'
        format.html { redirect_to(@usercase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usercase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usercases/1
  # DELETE /usercases/1.xml
  def destroy
    @usercase = Usercase.find(params[:id])
    @usercase.destroy

    respond_to do |format|
      format.html { redirect_to(usercases_url) }
      format.xml  { head :ok }
    end
  end
end
