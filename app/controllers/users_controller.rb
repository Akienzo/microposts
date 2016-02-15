class UsersController < ApplicationController
  #before_action :collect_user, only: [:edit, :update]  
  before_action :set_user,
                only: [:show, :edit, :update, :followings, :followers]
  # before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :authenticate!, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)  #ユーザーに紐付いたマイクロポストを作成日時が新しいものから取得し、@micropostsに代入しています。
  end
  
  def new
    @user = User.new     #Userクラスの新しいインスタンスを作成して、UsersControllerのインスタンス変数@userに代入しています。
  end
  
  def create
    @user = User.new(user_params)   #あらかじめルートのでresources :usersを設定していたので、createメソッドの@user.saveの後の
                                    #redirect_to @userの部分は、redirect_to user_path(@user)と同じように動作します。
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path 
    end 
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Edit to the Sample App!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :area, :password,:password_confirmation)
  end
  
  # get parameters for profile editing
  def user_profile
    params.require(:user).permit(:name, :email, :profile, :area, :password, :password_confirmation)
  end

  # get a user instance with :id parameter
  def set_user
    @user = User.find(params[:id])
  end

  # check current_user is editing self ?
  def authenticate!
    if @user != current_user
      redirect_to root_url, flash: { alert: "不正なアクセス" }
    end
  end
  # def collect_user
  # user = User.find(params[:id]) redirect_to(root_url) if user != current_user
  # end
end
