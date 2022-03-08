require 'rails_helper'

RSpec.describe 'Tags', type: :system do
  let!(:tag) { create(:tag) }
  let!(:topic) { create(:topic, tag_ids: tag.id) }
  let(:user) { create(:user) }
  def login(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  describe 'ログイン制限なしの機能' do
    describe 'タグごとの一覧表示' do
      context '正常系' do
        it 'タグに紐づいた会話のネタ一覧ページに遷移できる' do
          visit tag_path(tag)
          expect(current_path).to eq tag_path(tag)
          expect(page).to have_content "#{tag.name}での会話のネタ一覧"
        end
      end
      context '異常系' do
        it '作成されていないタグのidを指定すると、トップページに遷移する' do
          visit '/tags/100'
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン制限ありの機能' do
    describe 'ログインしていない場合' do
      it 'タグ一覧に遷移できない' do
        visit tags_path
        expect(current_path).to eq login_path
      end
      it 'タグ作成に遷移できない' do
        visit new_tag_path
        expect(current_path).to eq login_path
      end
    end

    describe 'ログインしている場合' do
      before{ login(user) }
      describe 'タグ一覧' do
        it 'タグ一覧ページに遷移でき、作成したタグが表示される' do
          visit tags_path
          expect(current_path).to eq tags_path
          expect(page).to have_content 'タグ一覧'
          expect(page).to have_content tag.name
        end
      end
      describe 'タグ作成' do
        it 'タグ作成ページに遷移できる' do
          visit new_tag_path
          expect(current_path).to eq new_tag_path
          expect(page).to have_content 'タグを作成'
        end
        context '正しく項目を入力している場合' do
          it 'タグ登録が成功し、タグ一覧ページに遷移する' do
            visit new_tag_path
            fill_in '新しいタグ', with: 'TEST'
            click_on '登録'
            expect(Tag.count).to eq 2
            expect(current_path).to eq tags_path
            expect(page).to have_content 'タグ：「TEST」を登録しました'
          end
        end
        context '新しいタグ欄が未入力の場合' do
          it 'タグ登録に失敗する' do
            visit new_tag_path
            fill_in '新しいタグ', with: nil
            click_on '登録'
            expect(Tag.count).to eq 1
            expect(current_path).to eq '/tags'
            expect(page).to have_content '新しいタグを入力してください'
          end
        end
        context '登録済みのタグだった場合' do
          it 'タグ登録に失敗する' do
            visit new_tag_path
            fill_in '新しいタグ', with: tag.name
            click_on '登録'
            expect(Tag.count).to eq 1
            expect(current_path).to eq '/tags'
            expect(page).to have_content '新しいタグはすでに存在します'
          end
        end
      end
      describe 'タグ削除' do
        it 'タスクの削除が成功する' do
          visit tags_path
          click_on '削除'
          expect(page.accept_confirm).to eq "タグ：「#{tag.name}」を削除してもよろしいですか？"
          expect(page).to have_content "タグ：「#{tag.name}」を削除しました"
          expect(current_path).to eq tags_path
          visit tags_path
          expect(page).not_to have_content tag.name
        end
      end
    end
  end
end