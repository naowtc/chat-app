class RoomsController < ApplicationController
  def index
  end
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    #どのチャットルームを削除するのかを特定する場合は、Room.find(params[:id])を使用して、削除したいチャットルームの情報を取得
    room = Room.find(params[:id])
    room.destroy
    #destroyメソッドが実行されたら、root（roomsのindex）にリダイレクトする
    redirect_to root_path
  end
  private

  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
  
end
    

    
