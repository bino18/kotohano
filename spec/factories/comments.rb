FactoryBot.define do
  factory :comment do
    content { 'コメントテスト' }
    user
    post
  end
end
