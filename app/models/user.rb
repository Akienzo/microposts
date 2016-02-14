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
    
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
      # 他のユーザーをフォローする 現在のユーザーのfollowing_relationshipsの中からフォローするユーザーのuser_idを含むものを探し、存在しない場合は、新しく作成します。
    def follow(other_user)
      following_relationships.find_or_create_by(followed_id: other_user.id)
      #数のパラメータと一致するものを1件取得し、存在する場合はそのオブジェクトを返し、存在しない場合は引数の内容で新しくオブジェクトを作成し、データベースに保存します。
    end
  
    # フォローしているユーザーをアンフォローする following_relationshipsからフォローしているユーザーのuser_idが入っているものを探し、存在する場合は削除します
    def unfollow(other_user)
      following_relationship = following_relationships.find_by(followed_id: other_user.id)
      following_relationship.destroy if following_relationship
    end
  
    # あるユーザーをフォローしているかどうか？ 他のユーザーがfollowing_usersに含まれているかチェックしています
    def following?(other_user)
      following_users.include?(other_user)
    end
  
end

# following_relationshipsのforeign_keyのfollower_idにuserのidが入るので、user.following_relationshipsによって、
# userがフォローしている場合のrelationshipの集まりを取得することができます。
# following_usersでは、has_many 〜 throughという文を使っています。
# throughには、following_relationshipsが指定されていて、上の図のように、
# following_relationshipsを経由してフォローしているユーザーの集まりを取得することを意味しています。
# userがフォローしている人は、following_relationshipsのfollowed_idに一致するユーザーになるので
# 、sourceとしてfollowedを指定しています。
# 逆にあるユーザー（user）をフォローしている人を取得できるようにするには、
# relationshipの集まりから、followed_idがuser.id（たとえば1）であるものを引っ張ってきて、そのfollower_idに一致するユーザーを探せばいいことになります。
