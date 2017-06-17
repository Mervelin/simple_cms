class AdminUsersController < ApplicationController
  layout 'admin'

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)

    if @admin_user.save
      flash[:notice] = 'AdminUser created successfully.'
      redirect_to(admin_users_path)
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])

    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = 'AdminUser updated successfully'
      redirect_to(admin_users_path)
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])

    @admin_user.destroy
    flash[:notice] = "AdminUser #{@admin_user} destroyed successfully."
    redirect_to(admin_users_path)
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :username, :password, :email)
  end
end
