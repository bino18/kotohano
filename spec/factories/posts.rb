FactoryBot.define do
  factory :post do
    title { '[テスト]Youtubeにアップする動画のタイトル' }
    body { '[テスト]動画のタイトル' }
    explanation { '[テスト]Vlog形式の動画のタイトル' }
    user
  end
end
