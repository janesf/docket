class RolesController < ApplicationController

#   before_filter  :check_read_access
   before_filter  :check_write_access, :only => [:new, :edit, :create, :update, :destroy]
   
   def check_read_access
      unless current_user.role.system_readwrite == true then
         flash[:notice]='Access denied.'
         if request.env['HTTP_REFERER'].nil? then
            redirect_to :controller => :admin, :action => :sign_in
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
                  
   # GET /roles
   # GET /roles.xml
   # GET /roles
   # GET /roles.xml
   def index
      @roles = Role.find(:all)
      respond_to do |format|
         format.html # index.html.erb
         format.xml { render :xml => @roles }
      end
   end
   
   # GET /roles/1
   # GET /roles/1.xml
   def show
      @role = Role.find(params[:id])
      respond_to do |format|
         format.html # show.html.erb
         format.xml { render :xml => @role }
      end
   end
   
   # GET /roles/new
   # GET /roles/new.xml
   def new
      @role = Role.new
      
      respond_to do |format|
         format.html # new.html.erb
         format.xml { render :xml => @role }
      end
   end
   
   # GET /roles/1/edit
   def edit
      @role = Role.find(params[:id])
   end
   
   # POST /roles
   # POST /roles.xml
   def create
      @role = Role.new(params[:role])
      respond_to do |format|
         if @role.save
            flash[:notice] = "Role #{@role.description} was successfully created."
            format.html { redirect_to(:action=>'index' ) }
            format.xml { render :xml => @role, :status => :created,
            :location => @role }
         else
            format.html { render :action => "new" }
            format.xml { render :xml => @role.errors,
            :status => :unprocessable_entity }
         end
      end
   end
   
   # PUT /roles/1
   # PUT /roles/1.xml
   def update
      @role = Role.find(params[:id])
      respond_to do |format|
         if @role.update_attributes(params[:role])
            flash[:notice] = "Role #{@role.description} was successfully updated."
            format.html { redirect_to(:action=>'index' ) }
            format.xml { head :ok }
         else
            format.html { render :action => "edit" }
            format.xml { render :xml => @role.errors,
            :status => :unprocessable_entity }
         end
      end
   end
   
   # DELETE /roles/1
   # DELETE /roles/1.xml
   def destroy
      @role = Role.find(params[:id])
      @role.destroy
      
      respond_to do |format|
         format.html { redirect_to(roles_url) }
         format.xml { head :ok }
      end
   end


end
