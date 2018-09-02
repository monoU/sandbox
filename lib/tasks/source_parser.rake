namespace :source_parser do

  task :expansion do
    # 書き出し先のmasterファイル
    master_file = File.open("db/master/expansion_master.yml", "w")
    # 読み込み
    File.open("db/source/expansion_source.txt") do |file|
      count = 0
      file.each do |line|
        count += 1
        s = line.split(", ")
        master_file.print("#{count}: name: #{s[0]}, abbr: #{s[1]}")
      end
    end
  end

  task :card do
    p "source_parser:card task start"
    count = 1
    # 書き出し先のmasterファイル
    master_file = File.open("db/master/card_master.yml", "w")
    # 読み込み
    File.open("db/source/card_source.txt") do |file|
      # カード情報の終わり end of card
      eoc = true
      # カードテキスト
      text = ""
      # yml一行
      data = ""
      file.each do |line|

        if data.empty?
          eoc = false
          data << "#{count}: {"
        end

        if line.match(/\p{blank}*英語名：/)
          data << "name: #{line.sub(/\p{blank}*英語名：/, "").chomp}, " 
        elsif line.match(/\p{blank}*日本語名：/)
          data << "name_ja: #{line.sub(/\p{blank}*日本語名：/, "").sub(/（.*/, "").chomp}, "
        elsif line.match(/\p{blank}*コスト：/)
          cost = line.sub(/\p{blank}*コスト：/, "").chomp
          colour = ""
          data << "cost: #{cost}, "
          if cost.include? "白"
            colour << "W"
          end
          if cost.include? "青"
            colour << "U"
          end
          if cost.include? "黒"
            colour << "B"
          end
          if cost.include? "赤"
            colour << "R"
          end
          if cost.include? "緑"
            colour << "G"
          end
          data << "colour: #{colour}, "
        elsif line.match(/\p{blank}*タイプ：/)
          types = line.sub(/\p{blank}*タイプ：/, "").sub(/\s+---.*/, "").chomp
          data << "types: #{types}, "
          if types == "クリーチャー"
            creature_types = []
            next if line.match(/\p{blank}*タイプ：クリーチャー --- (.+)/).nil?
            line.match(/\p{blank}*タイプ：クリーチャー --- (.+)/)[1].split("・").each do |type|
              creature_types << type.sub(/\(.+\)/, "")
            end
            data << "creature_type: #{creature_types.join(", ")}, "
          end
        elsif line.match(/\p{blank}*Ｐ／Ｔ：/)
          data << "power: #{line.sub(/\p{blank}*Ｐ／Ｔ：/, "").split("\/")[0].chomp}, toughness: #{line.sub(/\p{blank}*Ｐ／Ｔ：/, "").split("\/")[1].chomp}, "
        elsif line.match(/\p{blank}*イラスト：/)
          data << "arstist: #{line.sub(/\p{blank}*イラスト：/, "").chomp}, "
        elsif line.match(/\p{blank}*セット：/)
          data << "expansion: #{line.sub(/\p{blank}*セット：/, "").chomp}, "
        elsif line.match(/\p{blank}*稀少度：/)
          case (line.sub(/\p{blank}*稀少度：/, "").chomp)
            when "神話レア" then rarity = 0
            when "レア" then rarity = 1
            when "アンコモン" then rarity = 2
            else rarity = 3
          end
          data << "rarity: #{rarity}, "
          # レアリティでカード情報終了
          eoc = true
        elsif line.empty?
          next
        else
          # 能力
          text << line.chomp
        end

        if eoc
          data << "text: #{text}}"
          master_file.puts(data)
          count += 1
          data = ""
          text = ""
        end
      end
    end
    p "source_parser end! #{count} cards currently!"
  end
end
