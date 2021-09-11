FactoryBot.define do
  factory :post do
    title { 'タイトルのテスト' }
    body { '本文のテスト' }
    explanation { '説明文のテスト' }
    user
  end
end
