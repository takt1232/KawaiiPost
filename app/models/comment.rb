class Comment < ApplicationRecord
  after_create_commit :broadcast_stats_update

  belongs_to :user
  belongs_to :post

  validates :content, presence: :true

  private

  def broadcast_stats_update
    broadcast_update_to(
      "admin_dashboard",
      target: "comments-count",
      partial: "admin/dashboard/stats",
      locals: { count: Comment.count, type: "comments" }
    )
  end
end
