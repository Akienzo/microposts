class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
