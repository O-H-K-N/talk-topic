require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let!(:user) { create(:user) }

  describe '正常系' do
    context 'フォームが正しく入力されている場合' do
      it 'ログインできる' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(current_path).to eq tags_path
        expect(page).to have_content 'ログインしました'
      end
    end
  end

  describe '異常系' do
    context 'メールアドレス欄が空欄の場合' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
    context 'パスワード欄が空欄の場合' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        click_button 'ログイン'
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
    context '入力されたユーザが登録されていないの場合' do
      it 'ログインに失敗する' do
        visit login_path
        fill_in 'メールアドレス', with: 'aaa@aaa.com'
        fill_in 'パスワード', with: 'pass'
        click_button 'ログイン'
        expect(current_path).to eq login_path
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
  end
end