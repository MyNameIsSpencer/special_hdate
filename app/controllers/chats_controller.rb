class ChatsController < ApplicationController

  def chat_room
    @current_user = current_user
    if User.find_by(id: params[:receiver])
      @receiver = User.find_by(id: params[:receiver])
      @messages = Message.where(["user_id = ? and receiver_id = ? OR user_id = ? and receiver_id = ?", current_user.id, params[:receiver].to_i, params[:receiver].to_i, current_user.id]).order(created_at: :asc).pluck(:body, :user_id, :created_at, :id, :read)
      @messages.map {|m| m[1]=User.find(id=m[1]).name}
      respond_to do |format|
        format.html
        format.json { render :json => {message: @messages, sender: @current_user} }
      end
    else
      flash[:notice] = "Sorry, that user has deleted their Profile"
      redirect_to user_matches_url(@current_user.id)
    end
  end
end
