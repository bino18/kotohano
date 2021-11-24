require 'rails_helper'

describe 'コメント投稿機能', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  let(:post_a) {FactoryBot.create(:post, title: '一覧表示機能のテスト', user: user_a)}

  before do
    visit login_path
    fill_in 'メールアドレス', with: user_b.email
    fill_in 'パスワード', with: user_b.password
    click_button 'ログインする'
  end

  context 'ユーザーAの投稿にユーザーBがコメントする時' do
    before do
      visit post_path(post_a)
      fill_in 'コメントを投稿する', with: 'コメント投稿テスト'
      find('#evaluate_stars').find("img[alt='5']").click
      click_button '投稿'
    end

    it 'ユーザーBのコメントが表示される' do
      expect(page).to have_content 'コメント投稿テスト'
    end
  end
end
# bundle exec rspec spec/system/comments_spec.rb
