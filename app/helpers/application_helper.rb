module ApplicationHelper
  
   def get_provider
    session[:provider_id]
  end
  def home_page
   provider = Provider.find_by(email: params[:session][:email].downcase)
    if provider && provider.authenticate(params[:session][:password])
       log_in(provider)
      redirect_to provider #convert to root
    end
  end
end
