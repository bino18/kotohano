require 'rails_helper'

describe '投稿管理機能', type: :system do
  #ユーザーの作成
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  #ユーザーAによる投稿を作成
  let!(:post_a) {FactoryBot.create(:post, title: '投稿テスト', user: user_a)}

  before do
    #ログイン画面にアクセス
    visit login_path
    #各種項目を入力
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    #ログインボタンをクリック
    click_button 'ログインする'
  end

  #以下のitをshared_examples_forで共通化
  #it 'ユーザーAが作成した投稿が表示されない' do
    #expect(page).to have_no_content '投稿テスト'
  #end
  shared_examples_for 'ユーザーAが作成した投稿が表示される' do
    it { expect(page).to have_content '投稿テスト' }
  end

  describe 'ユーザー詳細画面の投稿一覧機能' do
    context 'ユーザーAがログインしている時' do
      #login_userにユーザーAを代入
      let(:login_user) { user_a }

      #一覧画面にユーザーAの投稿が表示されることを確認
      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end

    context 'ユーザーBがログインしている時' do
      #login_userにユーザーAを代入
      let(:login_user) { user_b }

      it 'ユーザーAが作成した投稿が表示されない' do
        #一覧画面にユーザーAの投稿が表示されないことを確認
        expect(page).to have_no_content '投稿テスト'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      #詳細画面にユーザーAの投稿が表示されることを確認
      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in 'タイトル', with: post_title
      fill_in '文章', with: post_body
      fill_in 'この言葉について', with: post_explanation
      click_button '投稿する'
    end

    context '新規作成画面でタイトルを入力した時' do
      let(:post_title) { '新規作成のテスト(タイトル)' }
      let(:post_body) { '新規作成のテスト(本文)'}
      let(:post_explanation) { '新規作成のテスト(説明)'}

      it '正常に投稿される' do
        expect(page).to have_content '新規作成のテスト(タイトル)'
      end
    end

    context '新規作成画面でタイトルを入力しなかった時' do
      let(:post_title) { '' }
      let(:post_body) { '新規作成のテスト(本文)'}
      let(:post_explanation) { '新規作成のテスト(説明)'}

      it 'エラーになる' do
        expect(page).to have_no_content '新規作成のテスト(タイトル)'
      end
    end
  end
end
# bundle exec rspec spec/system/posts_spec.rb
