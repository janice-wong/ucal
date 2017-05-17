class SessionsController < ApplicationController
  def new
    if params[:login] == "failure"
      @login_failure = "Wrong email / password. Please try again."
    end
    render 'login.html.erb'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/events?login=success'
    else
      redirect_to '/login?login=failure'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end