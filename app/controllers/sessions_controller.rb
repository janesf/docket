class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
   if user.nil?
     flash.now[:error] = "Invalid email/password combination."
     @title = "Sign in"
     render 'new'
   else
     sign_in user
     redirect_back_or user
   end
    # user = User.find_by_email(params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    #   sign_in user
    #   redirect_back_or user
    # else
    #   flash.now[:error] = 'Invalid email/password combination'
    #   render 'new'
    # end
  end
  
  def new
    @title = "Sign in"
  end


  def destroy
    sign_out
    redirect_to root_url
  end
end