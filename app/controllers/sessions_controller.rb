class SessionsController < ApplicationController
  def new
    render 'login.html.erb'
  end

  def create
    user = User.find_by(email: params[:email])
    p user
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      p "LOGGED IN"
      redirect_to '/events'
    else
      flash[:warning] = "Invalid email or password"
      p "INVALID"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end