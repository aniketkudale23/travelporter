module SessionsHelper
   def log_in(user)
    session[:provider_id] = user.id
  end
  
  def current_user
    @current_provider ||= Provider.find_by(id: session[:provider_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
 
   
end
