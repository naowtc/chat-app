class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    #チャットルームに紐付いている全てのメッセージ（@room.messages）を@messagesと定義し全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述
    @messages = @room.messages.includes(:user)
  end
#DBに値を保存できるように、createアクションを実装
  #@room.messages.newでチャットルームに紐づいたメッセージのインスタンスを生成し、message_paramsを引数にして、privateメソッドを呼び出す
  #その値を@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end
#privateメソッドとしてmessage_paramsを定義し、メッセージの内容(content)をmessagesテーブルへ保存。パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容(content)を受け取れるように許可します
private

def message_params
  params.require(:message).permit(:content).merge(user_id: current_user.id)
end
end
 
