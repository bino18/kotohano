require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'ユーザー編集機能' do
    let(:login_user) { user_a }

    context 'ユーザー編集画面で名前を変更した時' do
      before do
        visit edit_user_path(user_a)
        fill_in '名前', with: '一郎'
        click_button '更新する'
      end

      it '正常に更新される' do
        visit user_path(user_a)
        expect(page).to have_content '一郎'
      end
    end
  end
end
# bundle exec rspec spec/system/users_spec.rb
