require 'rails_helper'

RSpec.describe FoodEnquete, type: :model do
  describe '正常系の機能' do
    context '回答する' do
      it '正しく登録できること 料理:ラーメン food_id: 1,
                                  満足度:普通 score: 2,
                                  希望するプレゼント:ビール飲み放題 present_id: 1' do

        enquete = FoodEnquete.new(
          name: 'かと',
          mail: 'test@gmail.com',
          age: 22,
          food_id: 1,
          score: 2,
          request: 'いいね',
          present_id: 1
        )
        # 「バリデーションが正常に通ること(バリデーションエラーが無いこと)」を検証します。
        expect(enquete).to be_valid

        # テストデータを保存します。
        enquete.save
      end
    end
  end
end
