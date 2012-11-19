class AdminController < ApplicationController
   
   before_filter :check_authentication, :except => [:login]
   
   def login
      session[:user_id] = nil
      if request.post?
         user = User.authenticate(params[:name], params[:password])
         if user
            session[:user_id] = user.id
            uri = session[:original_uri]
            session[:original_uri] = nil
            redirect_to( uri || url_for( :controller => :users, :action => :show, :id => user.id ) )
         else
            flash.now[:notice] = "Invalid user/password combination"
         end
      end
   end
      
   def index
      @total_cases = Patentcase.count
      @total_cases = Patentcase.find_by_sql ["select count(p.id) from patentcases p, usercases u where p.id = u.patentcase_id and user_id =(?)", (session[:user_id]) ]
   end
   
   def logout
      session[:user_id] = nil
      flash[:notice] = "Logged out."
      redirect_to(:action => "login")
   end
   
   def check_authentication
      if session[:user_id].nil? then
         session[:intended_action] = action_name
         session[:intended_controller] = controller_name
         redirect_to :action => "login"
      end
   end
   
end
