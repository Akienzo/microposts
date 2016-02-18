class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]   #before_actionで、ApplicationControllerにあるlogged_in_userメソッドを実行し、
                                                     #ログインしていない場合はcreateメソッドは実行しないで/loginにリダイレクトする
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"        #パラメータを受け取って現在のユーザーに紐付いたMicropostのインスタンスを作成して@micropost変数に入れ、@micropost.saveで保存が成功した場合は、root_urlである/にリダイレクトを行い
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) #MicropostsControllerのcreateメソッドでもエラーが発生した場合はstatic_pages/homeテンプレートを使用
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
