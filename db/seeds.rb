stations = [
  { name: "東京", order_index: 1, mission: "東京駅で名物のお土産を探そう！" },
  { name: "神田", order_index: 2, mission: "神田の古書店街でお気に入りの本を見つけよう！" },
  { name: "秋葉原", order_index: 3, mission: "秋葉原でガチャガチャを1回回そう！" },
  { name: "御徒町", order_index: 4, mission: "御徒町のアメ横で食べ歩きをしよう！" },
  { name: "上野", order_index: 5, mission: "上野公園で写真を撮ろう！" },
  { name: "鶯谷", order_index: 6, mission: "鶯谷の歴史スポットを調べてみよう！" },
  { name: "日暮里", order_index: 7, mission: "日暮里繊維街で布を触ってみよう！" },
  { name: "西日暮里", order_index: 8, mission: "西日暮里でラーメンを食べよう！" },
  { name: "田端", order_index: 9, mission: "田端文士村記念館を調べてみよう！" },
  { name: "駒込", order_index: 10, mission: "六義園の写真を見てみよう！" },
  { name: "巣鴨", order_index: 11, mission: "巣鴨地蔵通り商店街で名物を探そう！" },
  { name: "大塚", order_index: 12, mission: "大塚の路面電車を見つけよう！" },
  { name: "池袋", order_index: 13, mission: "池袋サンシャイン周辺を調べてみよう！" },
  { name: "目白", order_index: 14, mission: "目白庭園の写真を見てみよう！" },
  { name: "高田馬場", order_index: 15, mission: "高田馬場の早稲田文化を調べてみよう！" },
  { name: "新大久保", order_index: 16, mission: "新大久保で韓国グルメを調べよう！" },
  { name: "新宿", order_index: 17, mission: "新宿の高層ビル群の写真を見てみよう！" },
  { name: "代々木", order_index: 18, mission: "代々木公園のスポットを調べてみよう！" },
  { name: "原宿", order_index: 19, mission: "原宿の最新スイーツを調べよう！" },
  { name: "渋谷", order_index: 20, mission: "渋谷スクランブル交差点の写真を見てみよう！" },
  { name: "恵比寿", order_index: 21, mission: "恵比寿ガーデンプレイスを調べてみよう！" },
  { name: "目黒", order_index: 22, mission: "目黒川の桜の写真を見てみよう！" },
  { name: "五反田", order_index: 23, mission: "五反田の名物グルメを調べよう！" },
  { name: "大崎", order_index: 24, mission: "大崎の再開発エリアを調べてみよう！" },
  { name: "品川", order_index: 25, mission: "品川駅の新幹線ホームを調べてみよう！" },
  { name: "田町", order_index: 26, mission: "田町の慶應義塾大学周辺を調べてみよう！" },
  { name: "浜松町", order_index: 27, mission: "浜松町の東京タワーを調べてみよう！" },
  { name: "新橋", order_index: 28, mission: "新橋のSL広場の写真を見てみよう！" },
  { name: "有楽町", order_index: 29, mission: "有楽町のガード下グルメを調べてみよう！" }
]

stations.each do |data|
  station = Station.find_or_create_by!(name: data[:name], order_index: data[:order_index])
  Mission.find_or_create_by!(station: station, content: data[:mission])
end

puts "山手線29駅 + ミッションの初期データを投入しました！"