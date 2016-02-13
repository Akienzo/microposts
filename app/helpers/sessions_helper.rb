module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])     # ログイン中の場合はログインしているユーザーを、ログインしていない場合はnilを返します。
  end
    
  def logged_in?
    !!current_user
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end