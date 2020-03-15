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

  describe '入力項目の有無' do
    context '必須入力であること' do
      # [Point.3-4-1]itを複数書くことができます。
      it 'お名前が必須であること' do
        new_enquete = FoodEnquete.new
        # [Point.3-4-2]バリデーションエラーが発生することを検証します。
        expect(new_enquete).not_to be_valid
        # [Point.3-4-3]必須入力のメッセージが含まれることを検証します。
        expect(new_enquete.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'メールアドレスが必須であること' do
        new_enquete = FoodEnquete.new
        expect(new_enquete).not_to be_valid
        expect(new_enquete.errors[:mail]).to include(I18n.t('errors.messages.blank'))
      end

      # [Point.3-4-1]itを複数書くことができます。
      it '登録できないこと' do
        new_enquete = FoodEnquete.new

        # [Point.3-4-4]保存に失敗することを検証します。
        expect(new_enquete.save).to be_falsey
      end
    end
    
    context '任意入力であること' do
      it 'ご意見・ご要望が任意であること' do
        new_enquete = FoodEnquete.new
        expect(new_enquete).not_to be_valid
        # [Point.3-4-6]必須入力のメッセージが含まれないことを検証します。
        expect(new_enquete.errors[:request]).not_to include(I18n.t('errors.messages.blank'))
      end
    end

    describe 'アンケート回答時の条件' do
      context '年齢を確認すること' do
        it '未成年はビール飲み放題を選択できないこと' do
          # [Point.3-5-3]未成年のテストデータを作成します。
          enquete_sato = FoodEnquete.new(
            name: '佐藤 仁美',
            mail: 'hitomi.sato@example.com',
            age: 19,
            food_id: 2,
            score: 3,
            request: 'おいしかったです。',
            present_id: 1   # ビール飲み放題
          )
    
          expect(enquete_sato).not_to be_valid
          # [Point.3-5-4]成人のみ選択できる旨のメッセージが含まれることを検証します。
          expect(enquete_sato.errors[:present_id]).to include(I18n.t('activerecord.errors.models.food_enquete.attributes.present_id.cannot_present_to_minor'))
        end
  
        it '成人はビール飲み放題を選択できないこと' do
          # [Point.3-5-5]未成年のテストデータを作成します。
          enquete_sato = FoodEnquete.new(
            name: '佐藤 仁美',
            mail: 'hitomi.sato@example.com',
            age: 20,
            food_id: 2,
            score: 3,
            request: 'おいしかったです。',
            present_id: 1   # ビール飲み放題
          )
    
          # [Point.3-5-6]「バリデーションが正常に通ること(バリデーションエラーが無いこと)」を検証します。
          expect(enquete_sato).to be_valid
        end
      end
    end

    describe '#adult?' do
      it '20歳未満は成人ではないこと' do
        foodEnquete = FoodEnquete.new
        # [Point.3-5-1]未成年になることを検証します。
        expect(foodEnquete.send(:adult?, 19)).to be_falsey
      end
      
      it '20歳以上は成人であること' do
        foodEnquete = FoodEnquete.new
        # [Point.3-5-2]成人になることを検証します。
        expect(foodEnquete.send(:adult?, 20)).to be_truthy
      end
    end

  end

end
