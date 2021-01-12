class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 18 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships
  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend
  has_many :inverted_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: "friend_id"
  has_many :friend_requests, through: :inverted_friendships, source: :user

  scope :all_except, ->(user) { where.not(id: user) }

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.status = true
    friendship.save
    second = Friendship.new
    second.user_id = friendship.friend_id
    second.friend_id = friendship.user_id
    second.status = true
    second.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
