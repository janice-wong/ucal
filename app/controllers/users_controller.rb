class UsersController < ApplicationController
  def new
    render 'signup.html.erb'
  end

  def create
    user = User.create(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      status: "active",
      preference: params[:preference]
    )

    Friendship.create(
      user_id: user.id,
      friend_id: User.find_by(name: "Janice").id
    )

    Friendship.create(
      user_id: user.id,
      friend_id: User.find_by(name: "Tom").id
    )

    redirect_to '/events'
  end

  def destroy
    user = User.find(params[:id])
    user.update(status: "inactive")
    redirect_to '/events'
  end
end
