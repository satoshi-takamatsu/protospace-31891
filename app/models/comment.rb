class Comment < ApplicationRecord
  belongs_to :user  # usersテーブルとのアソシエーション
  belongs_to :prototype  # prootypesテーブルとのアソシエーション
  # belongs_to :モデル単数
  validates :text, presence: true
end


