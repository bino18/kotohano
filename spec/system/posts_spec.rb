require 'rails_helper'

describe '投稿管理機能', type: :system do
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  before do
    FactoryBot.create(:post, title: '一覧表示機能のテスト', user: user_a)

    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}
      
      it 'ユーザーAが作成した投稿が表示される' do
        expect(page).to have_content '一覧表示機能のテスト'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) {user_b}

      it 'ユーザーAが作成した投稿が表示されない' do
        expect(page).to have_no_content '一覧表示機能のテスト'
      end
    end
  end

  describe '新規作成機能' do
    before do
      visit new_post_path
      fill_in 'タイトル', with: '[タイトル]新規作成機能のテスト'
      fill_in '文章', with: '[文章]新規作成機能のテスト'
      fill_in 'この言葉について', with: '[説明]新規作成機能のテスト'
      click_button '投稿する'
    end

    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}

      it '投稿が作成される' do
        expect(page).to have_content '[タイトル]新規作成機能のテスト'
      end
    end
    
    describe '投稿編集機能' do
      before do
        click_link '編集する'
        fill_in 'タイトル', with: '[タイトル]投稿編集機能のテスト'
        click_button '更新する'
      end

      context 'ユーザーAがログインしている時' do
        let(:login_user) {user_a}
  
        it '投稿が編集される' do
          expect(page).to have_content '[タイトル]投稿編集機能のテスト'
        end
      end
    end
  end
end

      
# bundle exec rspec spec/system/posts_spec.rb
