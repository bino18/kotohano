require 'rails_helper'

describe 'コメント管理機能', type: :system do
  #ユーザーA,Bの作成
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}

  #ユーザーAによる投稿を作成
  let!(:post_a) {FactoryBot.create(:post, user: user_a)}

  #ユーザーBでログイン
  before do 
    visit login_path
    fill_in 'メールアドレス', with: user_b.email
    fill_in 'パスワード', with: user_b.password
    click_button 'ログインする'
    visit post_path(post_a)
  end

  #ユーザーBでコメント投稿
  describe 'コメント投稿機能' do
    context 'コメントを入力した場合' do
      before do
        fill_in 'コメントを投稿する', with: 'コメントのテスト'
        click_button '投稿'
      end

      #正しく表示されているか
      it 'コメントが正しく表示される' do
        expect(page).to have_content 'コメントのテスト'
      end
    end
  end
end
# bundle exec rspec spec/system/comments_spec.rb
