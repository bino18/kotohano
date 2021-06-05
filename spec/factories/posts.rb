FactoryBot.define do
  factory :post do
    title { 'テストのタイトル' }
    body { 'テストを行う' }
    explanation { 'テストの説明' }
    user
  end
end
