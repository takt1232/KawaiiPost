class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc { |controller, model|
    controller.try(:current_admin) || controller.try(:current_user)
  }

  after_commit :broadcast_stats_update

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

    if activity = activities.last
      broadcast_prepend_to(
        "admin_dashboard",
        target: "activities",
        partial: "admin/dashboard/activity",
        locals: { activity: activity }
      )
    end
  end
end
