class UsersController < ApplicationController
  before_action :require_sign_in, only: :show
  before_action :set_user, only: :show
  before_action :require_current_user, only: :show

  def show
    @ratings = @user.values.includes(image: :theme).order(created_at: :desc)
    @ratings_close_to_average = @user.values
                                     .within_twenty_five_percent_of_image_average
                                     .includes(image: :theme)
                                     .order(created_at: :desc)
    @rating_count = @ratings.size
    @rated_image_count = @ratings.map(&:image_id).uniq.size
    @rated_theme_count = @ratings.map { |rating| rating.image.theme_id }.uniq.size
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:notice] = t("controllers.users.welcome")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def require_sign_in
    return if signed_in?

    redirect_to login_url, alert: t("controllers.users.require_sign_in")
  end

  def require_current_user
    return if current_user == @user

    redirect_to current_user, alert: t("controllers.users.profile_only")
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
