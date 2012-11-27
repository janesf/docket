class RemindersController < ApplicationController

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
                 
   # GET /reminders
   # GET /reminders.xml
   def index
      # all reminders for the current user

      
      if session[:action]
        @reminders = Aaction.find(session[:action]).reminders
      end
      if params[:aaction_id]
        @action = Aaction.find(params[:aaction_id])
        @patcase = Patentcase.find(@action.patentcase_id)
      end
      
      if params[:aaction_id]
        @action = Aaction.find(params[:aaction_id])
        @patcase = Patentcase.find(@action.patentcase_id)
        
      elsif params[:patentcase_id]
        @patcase = Patentcase.find(params[:patentcase_id])
        #@reminders = @patcase.reminders
        @reminders = @patcase.reminders
         #@reminders = current_user.patentcases.collect { |pcase| pcase.reminders }
         #@reminders = current_user.patentcases.reminders
      # all reminders for the current patentcase
      
      else
          @reminders = Reminder.all      
      end
       if session[:patentcase] then
        @patcase = Patentcase.find(session[:patentcase])  
        #@reminders = @patcase.reminders
        @reminders = @patcase.reminders
      # all reminders for the current aaction
      elsif session[:patentcase].nil? and session[:action].nil? then
        @reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.patentcase_id and u.user_id = (?) order by r.due_date", session[:user_id] ]
      end
        
        

      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @reminders }
      end
   end

  # GET /reminders/1
  # GET /reminders/1.xml
  def show
    if session[:action]
      @reminders = Aaction.find(session[:action]).reminders
    end
    if params[:aaction_id]
      @action = Aaction.find(params[:aaction_id])
      @patcase = Patentcase.find(@action.patentcase_id)
    end
    
    if params[:aaction_id]
      @action = Aaction.find(params[:aaction_id])
      @patcase = Patentcase.find(@action.patentcase_id)
      
    elsif params[:patentcase_id]
      @patcase = Patentcase.find(params[:patentcase_id])
      #@reminders = @patcase.reminders
      @reminders = @patcase.reminders
       #@reminders = current_user.patentcases.collect { |pcase| pcase.reminders }
       #@reminders = current_user.patentcases.reminders
    # all reminders for the current patentcase
    
    else
        @reminders = Reminder.all      
    end
     if session[:patentcase] then
      @patcase = Patentcase.find(session[:patentcase])  
      #@reminders = @patcase.reminders
      @reminders = @patcase.reminders
    # all reminders for the current aaction
    elsif session[:patentcase].nil? and session[:action].nil? then
      @reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.patentcase_id and u.user_id = (?) order by r.due_date", session[:user_id] ]
    end
    
    
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.xml
  def new
    if session[:patentcase]
      @patentcase = Patentcase.find(session[:patentcase])
    end
    if params[:patentcase_id]
      @patentcase = Patentcase.find(params[:patentcase_id])
    end
     # Patentcase.find(session[:patentcase]).attorneydocket
    
    
    @reminder ||= @patentcase.reminders.new
   # @reminder = Reminder.new
    @reminder.rstatus_id = 1
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.xml
  def create
    if not @patentcase
      @patentcase = Patentcase.find(params[:reminder][:patentcase_id])
    end
    @reminder = @patentcase.reminders.build(params[:reminder])
    #@reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        flash[:notice] = 'Reminder was successfully created.'
        format.html { redirect_to(patentcase_reminders_path(@patentcase)) }
        format.xml  { render :xml => @reminder, :status => :created, :location => @reminder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.xml
  def update
    if session[:action]
      @reminders = Aaction.find(session[:action]).reminders
    end
    if params[:aaction_id]
      @action = Aaction.find(params[:aaction_id])
      @patcase = Patentcase.find(@action.patentcase_id)
    end
    
    if params[:aaction_id]
      @action = Aaction.find(params[:aaction_id])
      @patcase = Patentcase.find(@action.patentcase_id)
      
    elsif params[:patentcase_id]
      @patcase = Patentcase.find(params[:patentcase_id])
      #@reminders = @patcase.reminders
      @reminders = @patcase.reminders
       #@reminders = current_user.patentcases.collect { |pcase| pcase.reminders }
       #@reminders = current_user.patentcases.reminders
    # all reminders for the current patentcase
    
    else
        @reminders = Reminder.all      
    end
     if session[:patentcase] then
      @patcase = Patentcase.find(session[:patentcase])  
      #@reminders = @patcase.reminders
      @reminders = @patcase.reminders
    # all reminders for the current aaction
    elsif session[:patentcase].nil? and session[:action].nil? then
      @reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.patentcase_id and u.user_id = (?) order by r.due_date", session[:user_id] ]
    end
    
    @reminder = Reminder.find(params[:id])
    if not @patentcase
      @patentcase = Patentcase.find(params[:reminder][:patentcase_id])
    end
    
    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        flash[:notice] = 'Reminder was successfully updated.'
        if @patcase and @action
          format.html { redirect_to(patentcase_aaction_reminders_path(@patcase, @action)) }
        elsif @patcase
          format.html { redirect_to(patentcase_reminders_path(@patcase)) }
        else
          format.html { redirect_to(@reminder) }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.xml
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to(reminders_url) }
      format.xml  { head :ok }
    end
  end
end
