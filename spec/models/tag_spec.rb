require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーション確認' do
    context '入力フォームが正しい場合' do
      it 'タグが作成されること' do
        tag = build(:tag)
        expect(tag).to be_valid
        expect(tag.errors).to be_empty
      end
    end
    context 'タグが未入力の場合' do
      it 'タグが作成されない' do
        tag = build(:tag, name: nil)
        expect(tag).to be_invalid
        expect(tag.errors[:name]).to eq ['を入力してください']
      end
    end
    context 'タグが1文字の場合' do
      it 'タグが作成されない' do
        tag = build(:tag, name: 'a')
        expect(tag).to be_invalid
        expect(tag.errors[:name]).to eq ['は2文字以上で入力してください']
      end
    end
    context 'タグが21文字以上の場合' do
      it 'タグが作成されない' do
        tag = build(:tag, name: 'aaaaaaaaaaaaaaaaaaaaa')
        expect(tag).to be_invalid
        expect(tag.errors[:name]).to eq ['は20文字以内で入力してください']
      end
    end
  end
end
