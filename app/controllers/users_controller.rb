# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_current_user, only: :show

  def show
    render locals: {
      facade: UserShowFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:success] = "Logged in as #{user.first_name + ' ' + user.last_name}"
      VerificationMailer.verification_email(user).deliver_now
    else
      flash[:error] = 'Username already exists'
      @user = User.new(user_params)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
