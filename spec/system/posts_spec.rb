require 'rails_helper'

describe '投稿管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { FactoryBot.create(:post, title: '最初のポスト', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したポストが表示される' do
    it { expect(page).to have_content '最初のポスト' }
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成したポストが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in 'タイトル', with: post_title
      click_button '投稿する'
    end

    context '新規作成画面でタイトルを入力した時' do
      let(:post_title) { '新規作成のテスト' }

      it '正常に投稿される' do
        visit posts_path
      end
    end
  end
end
# bundle exec rspec spec/system/posts_spec.rb
