class InventorshipsController < ApplicationController

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
                  
   # GET /inventorships
   # GET /inventorships.xml
   def index
      @inventorships = Inventorship.all
      @inventorships = Inventorship.find_by_sql ["select distinct i.* from Inventorships i, patentcases p, usercases u where u.patentcase_id = p.id and p.id = i.patentcase_id and u.user_id = (?) order by i.patentcase_id", session[:user_id] ]
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @inventorships }
      end
   end

  # GET /inventorships/1
  # GET /inventorships/1.xml
  def show
    @inventorship = Inventorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventorship }
    end
  end

def change_inventor_defaults
  logger.error( "HERE I AM!!!!!!" )   # Added to see if this is getting called
  @capacity = 3598                    # Set a nonsense value to see if it updates
  @cost = 850.03                      # ditto
  render :partial => 'inventor_defaults', :layout => false  # Is this necessary?
  puts "hello"
end

  # GET /inventorships/new
  # GET /inventorships/new.xml
  def new
    @inventorship = Inventorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventorship }
      selected_case = params[:patentcase_id]
    end
  selected_case = params[:patentcase_id]
    
  end
  # GET /inventorships/1/edit
  def edit
    @inventorship = Inventorship.find(params[:id])
    
  end

  # POST /inventorships
  # POST /inventorships.xml
  def create
    @inventorship = Inventorship.new(params[:inventorship])

    respond_to do |format|
      if @inventorship.save
        flash[:notice] = 'Inventorship was successfully created.'
        format.html { redirect_to(@inventorship) }
        format.xml  { render :xml => @inventorship, :status => :created, :location => @inventorship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventorships/1
  # PUT /inventorships/1.xml
  def update
    @inventorship = Inventorship.find(params[:id])

    respond_to do |format|
      if @inventorship.update_attributes(params[:inventorship])
        flash[:notice] = 'Inventorship was successfully updated.'
        format.html { redirect_to(@inventorship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventorships/1
  # DELETE /inventorships/1.xml
  def destroy
    @inventorship = Inventorship.find(params[:id])
    @inventorship.destroy

    respond_to do |format|
      format.html { redirect_to(inventorships_url) }
      format.xml  { head :ok }
    end
  end
end
