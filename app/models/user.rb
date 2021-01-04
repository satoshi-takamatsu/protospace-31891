class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates=データを保存する際に条件を指定する記述
  # :何のカラム
  # presence: true=保存できる
  # 条件の指定 length: { maximum 6 }は6文字まで
  # 条件の指定 length: { minimum 6 }は6文字以上必要
  # validates :email, presence: true emailとpasswordが空だと保存出来ないはデフォルトで設定されている
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true

  has_many :prototypes
  # dependent: :destroyはuserを削除したらコメントも削除というコード
  has_many :comments
  has_many_attached :images
end
