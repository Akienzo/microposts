class Micropost < ActiveRecord::Base
  belongs_to :user                     #それぞれの投稿は特定の1人のユーザーのものである。
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }    #contentが存在し、また、文字数は最大140。
end
