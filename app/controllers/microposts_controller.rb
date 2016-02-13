class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]   #before_actionで、ApplicationControllerにあるlogged_in_userメソッドを実行し、
                                                     #ログインしていない場合はcreateメソッドは実行しないで/loginにリダイレクトする
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"        #パラメータを受け取って現在のユーザーに紐付いたMicropostのインスタンスを作成して@micropost変数に入れ、@micropost.saveで保存が成功した場合は、root_urlである/にリダイレクトを行い
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
