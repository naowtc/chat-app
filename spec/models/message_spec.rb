require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
    end

    it 'contentとimageが存在していれば保存できること' do
      expect(@Message).to be_valid
      #contentとimageの両方が存在していれば、DBに正しく保存されるかを確認している
    end
    it 'contentが存在していれば保存できること' do
      @message.image = nil
      expect(@message).to be_valid
    end
    it 'imageが存在していれば保存できること' do
      @message.content = nil
      expect(@message).to be_valid
    end
    it 'contentとimageが空では保存できないこと' do
      @message.image = nil
      @message.content = nil
      @message.valid?
      expext(@message.errors.full_message).to include("Content can't be blank")
      #モデルファイルで設定したバリデーション（もしcontentとimageが空だったらDBに保存されない）が正常に起動するかを確認
    end

    it 'roomが紐付いていないと保存できないこと' do
      @message.room = nil
      @message.valid?
      expext(@message.errors.full_message).to include("Room must exist")
    end
    it 'userが紐付いていないと保存できないこと' do
      @message.user = nil
      @message.valid?
      expext(@message.errors.full_message).to include("User must exist")
    end
end
