class RulesController < ApplicationController

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
                  
  # GET /rules
  # GET /rules.xml
  def index
    @rules = Rule.find(:all, :order => :type_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.xml
  def show
    @rule = Rule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.xml
  def new
    @rule = Rule.new
    @rule.rmdroffset = 0
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
  end

  # POST /rules
  # POST /rules.xml
  def create
    @rule = Rule.new(params[:rule])

    respond_to do |format|
      if @rule.save
          Aaction.find_all_by_type_id(@rule.type_id).each do |b|
            a = @rule
            c = Reminder.new
            c.rstatus_id = 1
            c.case_id = b.patentcase_id
            c.rmdroffset = a.rmdroffset
            c.event_id = a.event_id
            c.type_id = a.type_id
            c.applytowatch =a.applytowatch
            c.refdttype_id = a.refdttype_id
            c.action_id = b.id
            c.save
          end
        
        flash[:notice] = 'Rule was successfully created.'
        
        format.html { redirect_to(@rule) }
        format.xml  { render :xml => @rule, :status => :created, :location => @rule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.xml
  def update
    @rule = Rule.find(params[:id])

    respond_to do |format|
      if @rule.update_attributes(params[:rule])
        flash[:notice] = 'Rule was successfully updated.'
        format.html { redirect_to(@rule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.xml
  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to(rules_url) }
      format.xml  { head :ok }
    end
  end
end
