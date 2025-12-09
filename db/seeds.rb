# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "既存データをクリア中..."
Post.destroy_all
Board.destroy_all
User.destroy_all

puts "ユーザーを作成中..."
users = [
  User.create!(name: "デモユーザー", email: "demo@example.com", password: "password", password_confirmation: "password"),
  User.create!(name: "太郎", email: "taro@example.com", password: "password", password_confirmation: "password"),
  User.create!(name: "花子", email: "hanako@example.com", password: "password", password_confirmation: "password"),
  User.create!(name: "智", email: "satoshi@example.com", password: "password", password_confirmation: "password"),
  User.create!(name: "ユキ", email: "yuki@example.com", password: "password", password_confirmation: "password")
]
puts "✓ #{users.count}人のユーザーを作成しました"

puts "掲示板を作成中..."
boards = [
  Board.create!(title: "職場の愚痴"),
  Board.create!(title: "今日のできごと"),
  Board.create!(title: "おすすめの本・映画"),
  Board.create!(title: "プログラミング相談"),
  Board.create!(title: "雑談部屋")
]
puts "✓ #{boards.count}個の掲示板を作成しました"

puts "投稿を作成中..."
sample_posts = [
  # 職場の愚痴
  { board: boards[0], user: users[1], body: "上司の指示がコロコロ変わってマジで困る。昨日と今日で言ってること違うし。", gentle_body: "上司の指示が頻繁に変わって、少し戸惑っています。昨日と今日で方針が変わったので、どう対応すればいいか考えています。" },
  { board: boards[0], user: users[2], body: "それわかる！こっちも混乱する。一貫性持ってほしいよね。", gentle_body: "その気持ち、とてもよく分かります。やはり指示には一貫性があると助かりますよね。" },
  { board: boards[0], user: users[3], body: "俺の上司も似たような感じ。メモとって記録残してる。", gentle_body: "私の上司も同じような傾向があります。念のため、指示内容をメモして記録に残すようにしています。" },
  
  # 今日のできごと
  { board: boards[1], user: users[1], body: "今日久々にカフェでゆっくりできた。最高だった〜", gentle_body: "今日は久しぶりにカフェでゆっくり過ごすことができました。とても良い時間でした。" },
  { board: boards[1], user: users[4], body: "いいね！どこのカフェ？", gentle_body: "それは素敵ですね！よろしければ、どちらのカフェか教えていただけますか？" },
  { board: boards[1], user: users[2], body: "電車で席譲ったら、めっちゃ感謝されて嬉しかった", gentle_body: "電車で席をお譲りしたところ、とても感謝していただけて嬉しい気持ちになりました。" },
  
  # おすすめの本・映画
  { board: boards[2], user: users[3], body: "最近読んだ本で面白かったのある人いる？教えて欲しい。", gentle_body: "最近、面白い本を読んだ方がいらっしゃいましたら、ぜひおすすめを教えていただけると嬉しいです。" },
  { board: boards[2], user: users[1], body: "SF好きなら『三体』おすすめ。マジで面白い。", gentle_body: "SF作品がお好きでしたら、『三体』をおすすめします。とても面白い作品です。" },
  { board: boards[2], user: users[4], body: "ありがとう！今度読んでみる！", gentle_body: "ありがとうございます！ぜひ読んでみますね。" },
  
  # プログラミング相談
  { board: boards[3], user: users[2], body: "Railsで非同期処理するときって何使ってる？Sidekiq？", gentle_body: "Railsで非同期処理を実装する際、皆さんは何を使用されていますか？Sidekiqでしょうか？" },
  { board: boards[3], user: users[3], body: "うちはSidekiq使ってる。設定も楽だし安定してる。", gentle_body: "私たちのプロジェクトではSidekiqを使用しています。設定も簡単で、安定して動作していますよ。" },
  { board: boards[3], user: users[1], body: "Solid Queueも最近話題だよね。Rails 8で標準になったし。", gentle_body: "Solid Queueも最近注目されていますね。Rails 8で標準機能として採用されました。" },
  
  # 雑談部屋
  { board: boards[4], user: users[4], body: "今日寒すぎない？もう冬って感じ。", gentle_body: "今日はとても寒いですね。もう冬の気配を感じます。" },
  { board: boards[4], user: users[2], body: "ほんとそれ。暖房つけちゃった。", gentle_body: "本当にそうですね。もう暖房をつけてしまいました。" },
  { board: boards[4], user: users[1], body: "明日の天気どうなんだろ。雨降るかな？", gentle_body: "明日の天気が気になりますね。雨が降るでしょうか。" },
  { board: boards[4], user: users[3], body: "週末どこか出かける予定ある人いる？", gentle_body: "週末にどこか出かける予定がある方はいらっしゃいますか？" },
  { board: boards[4], user: users[4], body: "映画見に行こうかなって思ってる。", gentle_body: "映画を見に行こうかと考えています。" }
]

sample_posts.each do |post_data|
  Post.create!(
    board: post_data[:board],
    user: post_data[:user],
    body: post_data[:body],
    gentle_body: post_data[:gentle_body]
  )
end

puts "✓ #{sample_posts.count}件の投稿を作成しました"

puts "\n========================================="
puts "シードデータの作成が完了しました！"
puts "========================================="
puts "ユーザー: #{User.count}人"
puts "  - demo@example.com (password: password)"
puts "  - taro@example.com (password: password)"
puts "  - hanako@example.com (password: password)"
puts "  - satoshi@example.com (password: password)"
puts "  - yuki@example.com (password: password)"
puts "掲示板: #{Board.count}個"
puts "投稿: #{Post.count}件"
puts "========================================="
