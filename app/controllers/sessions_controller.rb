class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email"=> params["email"]})
    if @user != nil
      # 2. if the user exists -> check if they know their password
      if BCrypt::Password.new(@user["password"]) == params["password"]
      # 3. if they know their password -> login is successful
      # 4. if the user doesn't exist or they don't know their password -> login fails
      
      # add cookies for the user
      cookies["monster"] = "me like cookies"
      session["user_id"] = @user["id"]
      
      flash["notice"] = "Welcome."
      redirect_to "/companies"
      else
        flash["notice"] = "Welcome."
        redirect_to "/companies"
      end
    else 
      flash["notice"] = "Email does not exist."
      redirect_to "/login"
    end
  end

  def destroy
    # logout the user
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
