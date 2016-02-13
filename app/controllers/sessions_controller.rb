class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)     #ユーザーをメールアドレスから検索。login画面で入力したメールアドレスとパスワードはparams[:session]に入っている
              #     もしユーザーが見つかった場合は、authenticateメソッドでパスワードが正しいか調べます。
              # パスワードが正しい場合は、session[:user_id]にユーザーIDを入れ、ユーザーの詳細ページにリダイレクトします。
              # パスワードが間違っている場合は’new’テンプレートを表示します。
    if @user && @user.authenticate(params[:session][:password])      
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    
    session[:user_id] = nil
    redirect_to root_path
  end
end

# ログアウト処理ではsession[:user_id]をnilにしています。これでサーバーとブラウザの両方でセッションの情報が破棄されます。
# アプリケーションのルート/にリダイレクトします。