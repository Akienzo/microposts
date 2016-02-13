class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper          #SessionsHelperモジュールを読み込んでいます。

  private
  def logged_in_user
    unless logged_in?             #ログインしていない場合（logged_in?がfalseのとき）のみ処理を行います。
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
