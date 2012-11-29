class StaticPagesController < ApplicationController


  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      #@micropost  = current_user.microposts.build
      
      @feed_items = current_user.feed.paginate(:page => params[:page])
      #@total_cases = Patentcase.find_by_sql ["select count(p.id) from patentcases p, usercases u where p.id = u.patentcase_id and user_id =(?)", (session[:user_id]) ]
    	#@total_cases = Patentcase.find_by_sql ["select count(p.id) from patentcases p, usercases u where p.id = u.patentcase_id and user_id =(?)", (session[:user_id]) ]
	    @total_cases = Patentcase.find_by_sql(["select count(p.id) from patentcases p where p.id in (select patentcase_id from  usercases u where user_id =?)", session[:user_id]])
    end
  end
  
  def help
  end
  def about
  end
  def contact
  end
end
