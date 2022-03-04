class LikesController < ApplicationController

  def create
    @like = Like.where(user_id: current_user.id,
                       likable_id: params[:likable_id],
                       likable_type: params[:likable_type])
    if @like.any?
      update
    else
      user_id = current_user.id
      liked = params[:liked]
      likable_type = params[:likable_type]
      likable_id = params[:likable_id]

      @like = Like.new(user_id: user_id, liked: liked,
                      likable_type: likable_type,
                      likable_id: likable_id)
      @like.save!
    end
  end

  def update
    @like = @like[0]

    case @like.liked
    when false
      remove_or_switch(params[:liked], 'false')
    when true
      remove_or_switch(params[:liked], 'true')
    end
  end

  private

  def remove_or_switch(new_liked, old_liked)
    return nil unless params[:liked] == 'true' || params[:liked] == 'false'

    if new_liked == old_liked
      @like.destroy
    elsif new_liked != old_liked
      @like.update(liked: new_liked)
    end
  end

end
