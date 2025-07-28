module ActivitiesHelper
  def activity_icon_class(activity)
    case activity.key
    when /post/ then "posts"
    when /comment/ then "comments"
    else "default"
    end
  end

  def activity_icon(activity)
    case activity.key
    when /post/ then "fas fa-file-alt"
    when /comment/ then "fas fa-comment"
    else "fas fa-bell"
    end
  end

  def activity_title(activity)
    case activity.key
    when "post.create" then "New post published"
    when "post.update" then "Post updated"
    when "comment.create" then "New comment received"
    else activity.key.humanize
    end
  end

  def activity_description(activity)
    if activity.trackable
      if activity.trackable.is_a?(Post)
        "\"#{activity.trackable.title}\" by #{activity.trackable.user.email}"
      elsif activity.trackable.is_a?(Comment)
        "\"#{activity.trackable.content.truncate(30)}\" on \"#{activity.trackable.post.title}\" by \"#{activity.trackable.user.email}"
      else
        activity.key.humanize
      end
    else
      "Item no longer available"
    end
  end
end
