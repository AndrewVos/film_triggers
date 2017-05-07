class TriggersController < ApplicationController
  def create
    trigger = Trigger.new(
      params
      .permit(:movie_id, :label)
      .merge(user: current_user)
    )
    trigger.save

    redirect_to movie_path(params[:movie_id])
  end
end
