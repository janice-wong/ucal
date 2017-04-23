class SessionsController < ApplicationController
  def new
    render 'login.html.erb'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:warning] = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end