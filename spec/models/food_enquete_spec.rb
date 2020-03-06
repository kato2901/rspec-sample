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

        # [Point.3-3-4][Point.3-3-3]で保存したデータを取得します。
        answered_enquete = FoodEnquete.find(1);

        # [Point.3-3-5][Point.3-3-1]で作成したデータを同一か検証します。
        expect(answered_enquete.name).to eq('かと')
        expect(answered_enquete.mail).to eq('test@gmail.com')
        expect(answered_enquete.age).to eq(22)
        expect(answered_enquete.food_id).to eq(1)
        expect(answered_enquete.score).to eq(2)
        expect(answered_enquete.request).to eq('いいね')
        expect(answered_enquete.present_id).to eq(1)
      end
    end
  end
end
