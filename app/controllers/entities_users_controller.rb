class EntitiesUsersController < ApplicationController
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
                  
   # GET /roles
   # GET /roles.xml
   # GET /roles
   # GET /roles.xml
   def index
      @entities_users = EntitiesUsers.all
      respond_to do |format|
         format.html # index.html.erb
         format.xml { render :xml => @entities_users }
      end
   end
   
   # GET /roles/1
   # GET /roles/1.xml
   def show
      @entities_user = EntitiesUsers.find([params[:entity_id],params[:user_id]])
      respond_to do |format|
         format.html # show.html.erb
         format.xml { render :xml => @entities_user }
      end
   end
   
   # GET /roles/new
   # GET /roles/new.xml
   def new
      @entities_user = EntitiesUsers.new
      
      respond_to do |format|
         format.html # new.html.erb
         format.xml { render :xml => @entities_user }
      end
   end
   
   # GET /roles/1/edit
   def edit
      @entities_user = EntitiesUsers.find({params[:entity_id],params[:user_id]})
   end
   
   # POST /roles
   # POST /roles.xml
   def create
      @entities_user = EntitiesUsers.new({params[:entity_id],params[:user_id]})
      respond_to do |format|
         if @entities_user.save
            user_name = User.find(@entities_user.user_id).name
            entity_name = Entity.find(@entities_user.entity_id).name
            flash[:notice] = "Association between #{user_name} and #{entity_name} was successfully created."
            format.html { redirect_to(:action=>'index' ) }
            format.xml { render :xml => @entities_user, :status => :created,
            :location => @entities_user }
         else
            format.html { render :action => "new" }
            format.xml { render :xml => @entities_user.errors,
            :status => :unprocessable_entity }
         end
      end
   end
   
   # PUT /roles/1
   # PUT /roles/1.xml
   def update
      @entities_user = EntitiesUsers.find({params[:entity_id],params[:user_id]})
      respond_to do |format|
         if @entities_user.update_attributes({params[:entity_id],params[:user_id]})
            user_name = User.find(@entities_user.user_id).name
            entity_name = Entity.find(@entities_user.entity_id).name
            flash[:notice] = "Association between #{user_name} and #{entity_name} was successfully updated."
            format.html { redirect_to(:action=>'index' ) }
            format.xml { head :ok }
         else
            format.html { render :action => "edit" }
            format.xml { render :xml => @entities_user.errors,
            :status => :unprocessable_entity }
         end
      end
   end
   
   # DELETE /roles/1
   # DELETE /roles/1.xml
   def destroy
      @entities_user = EntitiesUsers.find({params[:entity_id],params[:user_id]})
      @entities_user.destroy
      
      respond_to do |format|
         format.html { redirect_to(entities_users_url) }
         format.xml { head :ok }
      end
   end
end
