class Post < ApplicationRecord
  after_create_commit :broadcast_stats_update

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  private

  def broadcast_stats_update
    broadcast_update_to(
      "admin_dashboard",
      target: "posts-count",
      partial: "admin/dashboard/stats",
      locals: { count: Post.count, type: "posts" }
    )
  end
end
