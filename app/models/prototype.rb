class Prototype < ApplicationRecord
  # belongs_toを指定することにより、user_idが必要というバリデーションは不必要になる
  belongs_to :user #userテーブルとのアソシエーション
  has_one_attached :image
  has_many :comments, dependent: :destroy #commnetテーブルとのアソシエーション
  # dependent::destroyはprototypeを削除するとidで紐付いているcommentも削除されるというコード

  # has_many :モデル複数形
  
  # presence: true=保存できる
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true

  # def was_attached?
  #   self.image.attached?
  # end
end
