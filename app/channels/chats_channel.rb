class ChatsChannel < ApplicationCable::Channel

  def subscribed
    @room = params[:room].sort
    stream_from "chat_#{@room[0]}_#{@room[1]}"
  end

  def receive(data)
    sender = User.find(params[:room][0].to_i)
    receiver = User.find(params[:room][1].to_i)
    unless receiver.blocks.include?(sender.id)
      ActionCable.server.broadcast("chat_#{@room[0]}_#{@room[1]}", data)
    else
      data[:message]="Message not sent.  You have been blocked!!"
      ActionCable.server.broadcast("chat_#{@room[0]}_#{@room[1]}", data)
    end
  end

end
