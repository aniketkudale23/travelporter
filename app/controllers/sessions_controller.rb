class SessionsController < ApplicationController
  def new
  end
  
  def create
     provider = Provider.find_by(email: params[:session][:email].downcase)
    if provider && provider.authenticate(params[:session][:password])
       log_in(provider)
      redirect_to provider #convert to root
    else
       flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
    
    end
  

  def destroy
  end
  
  def home
   
    provider = Provider.find_by(id: current_user.id) rescue nil
    if provider 
      redirect_to provider #convert to root
    else
       flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end
  
end
