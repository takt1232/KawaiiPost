class User < ApplicationRecord
  after_create_commit :broadcast_stats_update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  private

  def broadcast_stats_update
    broadcast_update_to(
      "admin_dashboard",
      target: "users-count",
      partial: "admin/dashboard/stats",
      locals: { count: User.count, type: "users" }
    )
  end
end
