FactoryBot.define do
  factory :comment do
    content { '[テスト]読みやすくていいと思う' }
    evaluation { 4 }
    user
    post
  end
end
