class AactionsController < ApplicationController

  # before_filter  :check_read_access
   before_filter  :check_write_access, :only => [:new, :edit, :create, :update, :destroy]
   
   def check_read_access
      unless User.find(current_user_id).role.data_read == true then
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
                  
   # GET /aactions
   # GET /aactions.xml
   def index
     
      if session[:patentcase].nil? then
         @aactions = Aaction.find_by_sql ["select distinct a.* from aactions a, patentcases p, usercases u where u.patentcase_id = p.id and a.patentcase_id = p.id and u.user_id = (?) order by a.dtmailing", session[:user_id] ] 
      else
         @aactions = Aaction.find_by_sql ["select distinct a.* from aactions a, patentcases p, usercases u where u.patentcase_id = p.id and a.patentcase_id = p.id and p.id = (?) and u.user_id = (?) order by a.dtmailing", session[:patentcase], session[:user_id] ] 
      end
      if params[:patentcase_id]
          @patcase = Patentcase.find(params[:patentcase_id])
          @aactions = @patcase.aactions
          @entity = @patcase.entity
       #   @actions = Aaction.all
        else
          if session[:patentcase]
            @patcase = Patentcase.find(session[:patentcase])
            @aactions = @patcase.aactions
            @entity = @patcase.entity
          else
            @aactions = Aaction.all
          end
        end
        
        if params[:type_id]
          @type = Type.find(params[:type_id])
          @aactions = @type.aactions
          session[:type] = params[:type_id]
        end
        
        session[:patentcase]
     # session[:action] = nil
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @aactions }
      end
  end

  # GET /aactions/1
  # GET /aactions/1.xml
  def show
    @aaction = Aaction.find(params[:id])
    @case = Patentcase.find(@aaction.patentcase_id)
    @entity = @case.entity
    
     if not @case
       @case = Patentcase.find(session[:patentcase])
      @entity = @case.entity
     else
       @case = Patentcase.find(@aaction.patentcase_id)
        @entity = @case.entity
     end
    session[:action] = params[:id]
    session[:type] = @aaction.type_id
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aaction }
    end
  end

  # GET /aactions/new
  # GET /aactions/new.xml
  def new
    
    if session[:patentcase]
      @case = Patentcase.find(session[:patentcase])
       @entity = @case.entity
      
    end
    if params[:patentcase_id]
      @case = Patentcase.find(params[:patentcase_id])
       @entity = @case.entity
    end
    
    @aaction ||= @case.aactions.new
    session[:action] = @aaction.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aaction }
    end
  end

  # GET /aactions/1/edit
  def edit
    @aaction = Aaction.find(params[:id])
    @patentcase = Patentcase.find(params[:patentcase_id])
    @entity = @patentcase.entity  
    
    session[:action] = @aaction.id
  end

   # POST /aactions
   # POST /aactions.xml
   def create
     if params[:patentcase_id]
       @case = Patentcase.find(params[:patentcase_id])

     else
       if session[:patentcase]
         @case = Patentcase.find(session[:patentcase])
        end
    end
      @aaction = @case.aactions.build(params[:aaction])
#      @aaction = Aaction.new(params[:aaction])
  
      respond_to do |format|
         if @aaction.save then
         
            make_reminders
            session[:action] = @aaction.id
         
            flash[:notice] = 'Action was successfully created.'
            format.html { redirect_to(patentcase_aactions_path(@case)) }
            format.xml  { render :xml => @aaction, :status => :created, :location => @aaction }
         else
            format.html { render :action => "new" }
            format.xml  { render :xml => @aaction.errors, :status => :unprocessable_entity }
         end
      end
   end
   
   # PUT /aactions/1
   # PUT /aactions/1.xml
   def update
      @aaction = Aaction.find(params[:id])
      session[:action] = @aaction.action_id
      @case = Patentcase.find(params[:aaction][:patentcase_id])
      @entity = @case.entity
      respond_to do |format|
         if @aaction.update_attributes(params[:aaction])
         flash[:notice] = 'Aaction was successfully updated.'
         format.html { redirect_to(patentcase_aactions_path(@case)) }
         format.xml  { head :ok }
         else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @aaction.errors, :status => :unprocessable_entity }
         end
      end
   end


  
  
  # DELETE /aactions/1
  # DELETE /aactions/1.xml
  def destroy
    @aaction = Aaction.find(params[:id])
    @aaction.destroy
    session[:action] = nil

    respond_to do |format|
      format.html { redirect_to(aactions_url) }
      format.xml  { head :ok }
    end
  end
  
   def make_reminders
      @aaction.rules.each do |rule|
      
         @reminder = Reminder.new
         
         @reminder.aaction = @aaction
         
         # due date calculation
         month_offset = rule.rmdroffset.to_i
         @patent_case = @aaction.patentcase
         case Refdttype.find(rule.refdttype_id).dttype
         when "Action Mailing Date" then 
            relevant_date = @aaction.dtmailing 
         when "Case filing date" then  
            relevant_date = @patent_case.filingdate 
         when "Priority date" then 
            relevant_date = @patent_case.filingdate 
            Priority.find_all_by_child_id( @patent_case.id ).each do |parent|
               priority_date=Patentcase.find( parent.parent_id ).filingdate
               relevant_date=priority_date if priority_date < relevant_date
            end
         end
         
         @reminder.due_date = relevant_date >> month_offset
         
         @reminder.note = Event.find(rule.event_id).event
         
         @reminder.completed = false
         @reminder.completing_action = nil
         @reminder.date_completed = nil
         @reminder.dismissed = false
         @reminder.dismissed_by = nil
         @reminder.date_dismissed = nil
   
         # Reminder applies to all watching cases?  or subject case?
         if rule.applytowatch == true then
            Priority.find_all_by_parent_id( @patent_case.id ).each do |relationship|
               if relationship.watching 
                  @reminder.patentcase_id = relationship.child_id
                  @reminder.save 
               end
            end
         else
            @reminder.patentcase_id = @patent_case.id
            @reminder.save
         end
         
      end # of rule processing loop....
   end
end
