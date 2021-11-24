require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
  let(:user_a) {FactoryBot.create(:user)}
  before do
    visit '/'
    click_link 'ログインして投稿する'
  end

  describe 'ユーザー登録機能' do
    before do
      click_link '新しいアカウントを作成する'
      fill_in '名前', with: 'ユーザーA'
      fill_in 'メールアドレス', with: 'a@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認)', with: 'password'
      click_button '登録する'
    end

    it 'ユーザーAが作成される' do
      expect(page).to have_content 'ユーザーAを登録しました'
    end
  end

  describe 'ユーザーログイン機能' do
    before do
      fill_in 'メールアドレス', with: user_a.email
      fill_in 'パスワード', with: user_a.password
      click_button 'ログインする'
    end

    it 'ユーザーAでログインする' do
      expect(page).to have_content 'ログインしました'
    end
  end
end
# bundle exec rspec spec/system/users_spec.rb
