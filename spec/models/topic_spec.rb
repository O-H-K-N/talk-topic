require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:tag) { create(:tag)}

  describe 'バリデーション確認' do
    context '入力フォームが正しい場合' do
      it '会話のネタが作成されること' do
        topic = build(:topic, tag_ids: tag.id)
        expect(topic).to be_valid
        expect(topic.errors).to be_empty
      end
    end
    context '名前を未入力の場合' do
      it '会話のネタが作成されない' do
        topic = build(:topic, user_name: nil ,tag_ids: tag.id)
        expect(topic).to be_invalid
        expect(topic.errors[:user_name]).to eq ['を入力してください']
      end
    end
    context '会話のネタを未入力の場合' do
      it '会話のネタが作成されない' do
        topic = build(:topic, title: nil ,tag_ids: tag.id)
        expect(topic).to be_invalid
        expect(topic.errors[:title]).to eq ['を入力してください']
      end
    end
    context 'タグが未選択の場合' do
      it '会話のネタが作成されない' do
        topic = build(:topic)
        expect(topic).to be_invalid
        expect(topic.errors[:tag_ids]).to eq ['を入力してください']
      end
    end
    context '名前が1文字の場合' do
      it '会話のネタが作成されない' do
        topic = build(:topic, user_name: 'a' ,tag_ids: tag.id)
        expect(topic).to be_invalid
        expect(topic.errors[:user_name]).to eq ['は2文字以上で入力してください']
      end
    end
    context '名前が21文字以上の場合' do
      it '会話のネタが作成されない' do
        topic = build(:topic, user_name: 'aaaaaaaaaaaaaaaaaaaaa' ,tag_ids: tag.id)
        expect(topic).to be_invalid
        expect(topic.errors[:user_name]).to eq ['は20文字以内で入力してください']
      end
    end
  end
end
