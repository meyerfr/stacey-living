class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(users_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def users_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :date_of_birth, :job, :move_in_date, :duration_of_stay, :amount_of_people)
  end
end
