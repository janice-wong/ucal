class UsersController < ApplicationController
  def new
    if params[:signup] == "failure"
      @signup_failure = "Unsuccessful signup. Please try again."
    end
    render 'signup.html.erb'
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      status: "active",
      preference: params[:preference]
    )

    if user.save
      user = User.find_by(email: params[:email])
      session[:user_id] = user.id
      redirect_to '/events?login=success'
    else
      redirect_to "/signup?signup=failure"
    end
    
  end

  def destroy
    user = User.find(params[:id])
    user.update(status: "inactive")
    redirect_to '/events'
  end
end
