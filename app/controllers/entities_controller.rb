class EntitiesController < ApplicationController

#   before_filter  :check_read_access
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
                  
   # GET /entities
   # GET /entities.xml
   def index
     sort = params[:sort] || session[:sort]
     case sort
     when 'name'
       ordering,@title_header = {:order => :title}, 'hilite'
     when 'release_date'
       ordering,@date_header = {:order => :release_date}, 'hilite'
     end
     @all_entitytypes = Entity.all_entitytypes
     @selected_entitytypes = params[:entitytypes] || session[:entitytypes] || {}

     if @selected_entitytypes == {}
       @selected_entitytypes = Hash[@all_entitytypes.map {|entitytype| [entitytype, entitytype]}]
     end

     if params[:sort] != session[:sort]
       session[:sort] = sort
       flash.keep
       redirect_to :sort => sort, :entitytypes => @selected_entitytypes and return
     end

     if params[:entitytypes] != session[:entitytypes] and @selected_entitytypes != {}
       session[:sort] = sort
       session[:entitytypes] = @selected_entitytypes
       flash.keep
       #redirect_to :sort => sort, :entitytypes => @selected_entitytypes and return
       redirect_to :entitytypes => @selected_entitytypes and return
     end
     
     @entities = Entity.find_all_by_entitytype(@selected_entitytypes.keys)  
     @selected_types = params[:entitytypes] || session[:entitytypes] || {}

     if @selected_entitytypes == {}
       @selected_entitytypes = Hash[@all_entitytypes.map {|entitytype| [entitytype, entitytype]}]
     end
     
      # This was Jane's logic (I want users authorized per entity, not per case):
      #@entities = Entity.find_by_sql(["select distinct e.* from entities e, patentcases p, usercases u where u.patentcase_id = p.id and e.id = p.entity_id and u.user_id = (?) order by e.id", session[:user_id]])
     # session[:entity] = nil
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @entities }
      end
   end
   
   # GET /entities/1
   # GET /entities/1.xml
   def show
      @entity = Entity.find(params[:id])
      @type = @entity.entitytype
      session[:entity] = @entity.id
   
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @entity }
      end
   end
   
   # GET /entities/new
   # GET /entities/new.xml
   
   def new
       @entity = Entity.new
      # session[:entity] = @entity.id
      #    
      # respond_to do |format|
      #    format.html # new.html.erb
      #    format.xml  { render :xml => @entity }
      # end
   end
   
   
   # GET /entities/1/edit
   def edit
      @entity = Entity.find(params[:id])
      session[:entity] = @entity.id
   end
   
   # POST /entities
   # POST /entities.xml
   def create
     @entity = Entity.create!(params[:entity])
     flash[:notice] = "#{@entity.name} was successfully created."
     redirect_to entities_path
   end   
   # def create
   #    @entity = Entity.new(params[:entity])
   #   
   #    respond_to do |format|
   #       if @entity.save and @user.entities<<@entity then
   #          session[:entity] = @entity.id
   #          flash[:notice] = 'Entity was successfully created.'
   #          format.html { redirect_to(@entity) }
   #          format.xml  { render :xml => @entity, :status => :created, :location => @entity }
   #       else
   #          format.html { render :action => "new" }
   #          format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
   #       end
   #    end
   # end
   
   # PUT /entities/1
   # PUT /entities/1.xml
   def update
      @entity = Entity.find(params[:id])
      session[:entity] = @entity.id
   
      respond_to do |format|
         if @entity.update_attributes(params[:entity])
         flash[:notice] = 'Entity was successfully updated.'
         format.html { redirect_to(@entity) }
         format.xml  { head :ok }
         else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @entity.errors, :status => :unprocessable_entity }
         end
      end
   end
   
   # DELETE /entities/1
   # DELETE /entities/1.xml
   def destroy
      @entity = Entity.find(params[:id])
      @entity.destroy
      session[:entity] = nil
   
      respond_to do |format|
         format.html { redirect_to(entities_url) }
         format.xml  { head :ok }
      end
   end
end
