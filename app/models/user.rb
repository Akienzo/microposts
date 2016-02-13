class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :area, presence: true, length: { maximum: 50 }, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password     #データベースに安全にハッシュ化（暗号化）されたpassword_digestを保存する。
                            #passwordとpassword_confirmationをモデルに追加して、パスワードの確認が一致するか検証する。
                            #パスワードが正しいときに、ユーザーを返すauthenticateメソッドを提供する。
    has_many :microposts    #それぞれのユーザーは複数の投稿を持つことができる。
  
end
