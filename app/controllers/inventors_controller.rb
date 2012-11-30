class InventorsController < ApplicationController

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
                     
   # GET /inventors
   # GET /inventors.xml
   def index
      if session[:entity].nil? then
         if current_user.role.system_readwrite == true then
            @inventors = Inventor.all
            
         else
            #@inventors = Inventor.find_by_sql ["select distinct ii.* from inventors ii, Inventorships i, usercases u where u.patentcase_id = i.patentcase_id and i.inventor_id = ii.id and u.user_id = (?) order by i.patentcase_id", session[:user_id] ]
            @inventors = current_user.entity.inventors
            
         end

      elsif session[:entity]
          @entity = Entity.find(session[:entity])
         @inventors = Entity.find(session[:entity]).inventors
      elsif current_user.entity

      else
        # @inventors = Entity.find(session[:entity]).inventors
        @entity =  current_user.entity
        @inventors = current_user.entity.inventors
       if params[:entity_id] 
         @entity = Entity.find(params[:entity_id])
         @inventors = @entity.inventors
       end
      end
    
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @inventors }
      end
   end
   
   # GET /inventors/1
   # GET /inventors/1.xml
   def show
      @inventor = Inventor.find(params[:id])
      @entity = @inventor.entity
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @inventor }
      end
   end
   
   # GET /inventors/new
   # GET /inventors/new.xml
   def new
      @inventor = Inventor.new
      @entity = @inventor.entity
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @inventor }
      end
   end
   
   # GET /inventors/1/edit
   def edit
      @inventor = Inventor.find(params[:id])
      
      @entity = @inventor.entity
   end
   
   # POST /inventors
   # POST /inventors.xml
   def create
      @inventor = Inventor.new(params[:inventor])
      @entity = @inventor.entity
      respond_to do |format|
         if @inventor.save
         flash[:notice] = 'Inventor was successfully created.'
         format.html { redirect_to(@inventor) }
         format.xml  { render :xml => @inventor, :status => :created, :location => @inventor }
         else
         format.html { render :action => "new" }
         format.xml  { render :xml => @inventor.errors, :status => :unprocessable_entity }
         end
      end
   end
   
   # PUT /inventors/1
   # PUT /inventors/1.xml
   def update
      @inventor = Inventor.find(params[:id])
   @entity = @inventor.entity
      respond_to do |format|
         if @inventor.update_attributes(params[:inventor])
         flash[:notice] = 'Inventor was successfully updated.'
         format.html { redirect_to(@inventor) }
         format.xml  { head :ok }
         else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @inventor.errors, :status => :unprocessable_entity }
         end
      end
   end
   
   # DELETE /inventors/1
   # DELETE /inventors/1.xml
   def destroy
      @inventor = Inventor.find(params[:id])
      @inventor.destroy
   
      respond_to do |format|
         format.html { redirect_to(inventors_url) }
         format.xml  { head :ok }
      end
   end
end
