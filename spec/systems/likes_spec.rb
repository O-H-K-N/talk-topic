require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let!(:tag) { create(:tag) }
  let!(:topic) { create(:topic, tag_ids: tag.id) }

  describe 'いいね機能の確認' do
    context 'いいね画像をクリックすると' do
      it 'いいね数が1増える' do
        visit topics_path
        click_on 'like_button'
        expect(Like.count).to eq 1
        expect(find('.like_counter')).to have_content "1"
      end
    end
  end
end