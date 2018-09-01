namespace :seed_maker do

  task :expansion do
    # 書き出し先のmasterファイル
    seed_file = File.open("db/master/expansion_master.yml", "w")
    # 読み込み
    File.open("db/source/expansion_source.txt") do |file|
      count = 0
      file.each do |line|
        count += 1
        s = line.split(", ")
        seed_file.print("#{count}: name: #{s[0]}, abbr: #{s[1]}")
      end
    end
  end

  task :card do

  end
end
