class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :load_references, only: [:show, :new, :create, :edit, :update, :destroy]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  decorates_assigned :users

  # GET /admin/users or /admin/users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 25)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show; end

  # GET /admin/users/new
  def new
    @user = User.new
    @user.build_user_profile
  end

  # GET /admin/users/1/edit
  def edit; end

  # POST /admin/users or /admin/users.json
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('views.users.form.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('views.users.form.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    @user.destroy!
    redirect_to admin_users_url, notice: t('views.users.form.destroy')
  end

  private

  def load_references
    @profiles = Profile.order(description: :asc)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    temp_params = params.require(:user).permit(
      :uid,
      :active,
      :name,
      :login,
      :email,
      :password,
      :password_confirmation,
      :extern,
      user_profile_attributes: [
        :id,
        :profile_id
      ]
    )
    return temp_params if temp_params[:password].present?
    temp_params.except(:password, :password_confirmation)
  end
end
