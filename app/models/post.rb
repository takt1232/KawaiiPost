class Post < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc { |controller, model|
    controller.try(:current_admin) || controller.try(:current_user)
  }

  after_commit :broadcast_stats_update

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :published_date, presence: true

  private

  def broadcast_stats_update
    broadcast_update_to(
      "admin_dashboard",
      target: "posts-count",
      partial: "admin/dashboard/stats",
      locals: { count: Post.count, type: "posts" }
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
