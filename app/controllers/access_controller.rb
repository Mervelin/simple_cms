class AccessController < ApplicationController
  layout 'admin'

  skip_before_action :confirm_logged_in, except: 'menu'

  def menu
    # display text & links
    @username = session[:username]
  end

  def login
    # login form
  end

  def attempt_login
    return unless params[:username] && params[:password]

    found_user = AdminUser.find_by(username: params[:username])

    return unless found_user

    authorized_user = found_user.authenticate(params[:password])

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = 'You are now logged in.'
      redirect_to(admin_path)
    else
      flash.now[:notice] = 'Invalid username/password combination.'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out'
    redirect_to(access_login_path)
  end


end
