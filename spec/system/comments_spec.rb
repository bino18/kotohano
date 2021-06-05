require 'rails_helper'

describe 'コメント管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { FactoryBot.create(:post, title: '最初のポスト', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'コメント投稿機能' do
    let(:login_user) {user_b}

    before do
      visit post_path(post_a)
      fill_in 'コメントを投稿する', with: '最初のコメント'
      click_button '投稿する'
    end

    context '投稿詳細画面でコメントを入力した時' do
      it 'コメントが投稿される' do
        expect(page).to have_content '最初のコメント'
      end
    end
    context '投稿詳細画面でコメントの削除ボタンを押した時' do
      it 'コメントが削除される' do
        click_link '削除'
        expect(page).to have_no_content '最初のコメント'
      end
    end
  end
end
# bundle exec rspec spec/system/comments_spec.rb
