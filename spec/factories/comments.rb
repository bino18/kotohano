FactoryBot.define do
  factory :comment do
    content { 'コメントのテスト' }
    evaluation { 3 }
    user
    post
  end
end
