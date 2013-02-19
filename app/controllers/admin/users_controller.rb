class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show,
                                      :edit,
                                      :update,
                                      :destroy]
  def index
    @users = User.all(order: "email")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user], :as => :admin)
    if @user.save
      flash[:notice] = "User has been created."
      # redirect_to admin_user_path(@user) # why not this?
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render action: 'new'
    end
  end

  def show
  end

  def update
    @user.skip_reconfirmation!
    if @user.update_attributes(params[:user], :as => :admin)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render :action => "edit"
    end
end

  private
  def find_user
    @user = User.find(params[:user])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for was not found."
    redirect_to admin_root
  end
end
