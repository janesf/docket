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
      if session[:patentcase].nil? and session[:action].nil? then
         @reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.patentcase_id and u.user_id = (?) order by r.due_date", session[:user_id] ]
         #@reminders = current_user.patentcases.collect { |pcase| pcase.reminders }
         #@reminders = current_user.patentcases.reminders
      # all reminders for the current patentcase
      elsif session[:action].nil? then
         #@reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.case_id and p.id = (?) and u.user_id = (?) order by r.due_date", session[:patentcase], session[:user_id] ]
         @reminders = Patentcase.find(session[:patentcase]).reminders
      # all reminders for the current aaction
      else
         #@reminders = Reminder.find_by_sql ["select distinct r.* from reminders r, patentcases p, usercases u where u.patentcase_id = p.id and p.id = r.case_id and r.action_id = (?) and u.user_id = (?) order by r.due_date", session[:action], session[:user_id] ]
         @reminders = Aaction.find(session[:action]).reminders
      end

      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @reminders }
      end
   end

  # GET /reminders/1
  # GET /reminders/1.xml
  def show
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.xml
  def new
    @reminder = Reminder.new
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
    @reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        flash[:notice] = 'Reminder was successfully created.'
        format.html { redirect_to(@reminder) }
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
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        flash[:notice] = 'Reminder was successfully updated.'
        format.html { redirect_to(@reminder) }
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
