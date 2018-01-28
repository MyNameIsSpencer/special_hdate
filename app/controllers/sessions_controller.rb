class SessionsController < ApplicationController

  def new
    redirect_to user_path(session[:user_id]) if session[:user_id]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.update(status: 'Online')
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = ["Log in FAILED!! email and/or password is WRONG"]
      render :new
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    user.update(status: 'Offline')
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logged out!"
  end

end
