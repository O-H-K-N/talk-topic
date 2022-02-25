require 'rails_helper'

RSpec.describe 'Topics', type: :system do
  let!(:tag) { create(:tag) }

  describe '一覧' do
    context '投稿なし' do
      it '会話のネタの投稿を促すメッセージが表示' do
        visit topics_path
        expect(page).to have_content '会話のネタを提供してください。。。'
      end
    end
    context '投稿あり' do
      let!(:topic) { create(:topic, tag_ids: tag.id) }
      it '作成した投稿が表示されている' do
        visit topics_path
        expect(page).to have_content topic.user_name
        expect(page).to have_content topic.title
      end
    end
  end

  describe '新規作成' do
    context '正常系' do
      it '会話のネタを新規作成できる' do
        visit topics_path
        click_on '会話のネタを提供する'
        fill_in 'お名前', with: '投稿者のお名前'
        fill_in '会話のネタ', with: '会話のネタ'
        check `topic[tag_ids][]`
        click_on '登録'
        expect(Topic.count).to eq 1
        expect(current_path).to eq topics_path
        expect(page).to have_content 'ネタの提供ありがとうございます！'
      end
    end
    context '異常系' do
      it 'お名前欄が未入力の場合、会話のネタの作成に失敗する' do
        visit topics_path
        click_on '会話のネタを提供する'
        fill_in 'お名前', with: nil
        fill_in '会話のネタ', with: '会話のネタ'
        check `topic[tag_ids][]`
        click_on '登録'
        expect(Topic.count).to eq 0
        expect(current_path).to eq '/topics'
        expect(page).to have_content 'お名前を入力してください'
      end
      it '会話のネタ欄が未入力の場合、会話のネタの作成に失敗する' do
        visit topics_path
        click_on '会話のネタを提供する'
        fill_in 'お名前', with: '投稿者のお名前'
        fill_in '会話のネタ', with: nil
        check `topic[tag_ids][]`
        click_on '登録'
        expect(Topic.count).to eq 0
        expect(current_path).to eq '/topics'
        expect(page).to have_content '会話のネタを入力してください'
      end
      it 'タグが未選択の場合、会話のネタの作成に失敗する' do
        visit topics_path
        click_on '会話のネタを提供する'
        fill_in 'お名前', with: '投稿者のお名前'
        fill_in '会話のネタ', with: '会話のネタ'
        click_on '登録'
        expect(Topic.count).to eq 0
        expect(current_path).to eq '/topics'
        expect(page).to have_content 'タグを入力してください'
      end
    end
  end
end
