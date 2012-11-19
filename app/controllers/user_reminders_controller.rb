class UserRemindersController < ApplicationController
  # GET /user_reminders
  # GET /user_reminders.xml
  def index
    @user_reminders = UserReminder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_reminders }
    end
  end

  # GET /user_reminders/1
  # GET /user_reminders/1.xml
  def show
    @user_reminder = UserReminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_reminder }
    end
  end

  # GET /user_reminders/new
  # GET /user_reminders/new.xml
  def new
    @user_reminder = UserReminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_reminder }
    end
  end

  # GET /user_reminders/1/edit
  def edit
    @user_reminder = UserReminder.find(params[:id])
  end

  # POST /user_reminders
  # POST /user_reminders.xml
  def create
    @user_reminder = UserReminder.new(params[:user_reminder])

    respond_to do |format|
      if @user_reminder.save
        flash[:notice] = 'UserReminder was successfully created.'
        format.html { redirect_to(@user_reminder) }
        format.xml  { render :xml => @user_reminder, :status => :created, :location => @user_reminder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_reminders/1
  # PUT /user_reminders/1.xml
  def update
    @user_reminder = UserReminder.find(params[:id])

    respond_to do |format|
      if @user_reminder.update_attributes(params[:user_reminder])
        flash[:notice] = 'UserReminder was successfully updated.'
        format.html { redirect_to(@user_reminder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_reminders/1
  # DELETE /user_reminders/1.xml
  def destroy
    @user_reminder = UserReminder.find(params[:id])
    @user_reminder.destroy

    respond_to do |format|
      format.html { redirect_to(user_reminders_url) }
      format.xml  { head :ok }
    end
  end
end
