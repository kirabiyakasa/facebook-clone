module ApplicationHelper
  include Pagy::Frontend

  def likes_dislikes_container(content)
    status = liked?(content)
    "<div class=\"likes-dislikes\" data-liked=\"#{status}\">"
  end

  def liked?(content)
    like = Like.find_by(user_id: current_user.id,
                        likable_type: content.class.name,
                        likable_id: content.id)
    unless like == nil
      if like.liked
        return true
      else
        return false
      end
    else
      return nil
    end
  end

end
