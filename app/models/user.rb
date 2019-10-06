class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attachment :profile_image
  #1:N
  has_many :books, dependent: :destroy

#ユーザープロフィールの文字制限
  validates :name, presence: true, length:{minimum:2}
  validates :name, length:{maximum:20}
  validates :introduction, length:{maximum:50}
end
