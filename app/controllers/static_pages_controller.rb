class StaticPagesController < ApplicationController
 def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
 end
end

# 追加した@feed_items = で始まる行では、feed_itemsで現在のユーザーのフォローしているユーザーのマイクロポストを取得し、
# order(created_at: :desc)で作成日時が新しいものが上にくるように並び替えを行っています。
# includes(:user)の部分は、つぶやきに含まれるユーザー情報をあらかじめ先読み（プリロード）する処理を行うために用います。
# これにより、@feed_itemsからアイテムを取り出すたびに、それに紐付いたユーザーの情報をDBから取り出さずに済みます。
