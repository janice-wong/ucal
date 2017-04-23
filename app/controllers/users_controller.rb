class UsersController < ApplicationController
  def new
    render 'signup.html.erb'
  end

  def create
    User.create(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      status: "active"
    )
    redirect_to '/events'
  end

  def destroy
    user = User.find(params[:id])
    user.update(status: "inactive")
    redirect_to '/events'
  end
end
