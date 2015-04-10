# This module is intended to be included by Sinatra web apps, and Grape APIs
module Authenticated

  # When using vCards as an admin user, we allow the authname to be set so the
  # admin user may open a number of user accounts simultaneously
  def current_user(authname = nil)
    if authname ||= headers['X-Authname']
      @current_user ||= User.find(session[authname]) rescue nil
    else
      @current_user ||= User.find(session[:user_id]) rescue nil
    end
  end

  # The authname is passed only if the app controller finds it in the URL
  # An example of an authname is "@hutchike" i.e. a username with a leading "@"
  def authenticate!(authname = nil)
    # API version
    error!('401 Unauthorized', 401) unless current_user(authname)
  rescue NoMethodError => e
    # Web version
    flash[:notice] = "Please sign in first"
    redirect "/"
  end
end
