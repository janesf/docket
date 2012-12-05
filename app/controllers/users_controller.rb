class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

  end

  def create
    @user = User.new(params[:user])
    
    #for now making all new users admin
    #@user.role_id = 1 
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the IveyLaw.org!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def edit
    @user = User.find(params[:id])
    
    @user.entity = Entity.find(params[:entity_id]) if params[:entity_id]
    @user.entity ||= Entity.find(session[:entity]) if session[:entity]
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def update
   # @user = User.find(params[:id])
   
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Watching"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Watchers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end  
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
