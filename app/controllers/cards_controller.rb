class CardsController < ApplicationController
  def index
    @search = Search::Card.new
    @cards = {}
  end

  def search
    if params[:search_card].present?
      @search = Search::Card.new(search_card_parameters)
      # 検索条件によって検索
      @cards = @search.match
      @action = "search"
      render :action => "index"
    else
      redirect_to cards_path
    end
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_parameters)
    @card.save!
    flash[:notice] = "#{@card.name_ja} を追加しました"
    redirect_to cards_path
  end

  # todo 現状、一枚目が登録済みだとロールバック走って、後続が全くインポートされてない
  def import
    begin
      count = 0
      File.open("app/assets/file/ixalan.txt") do |file|
        file.each do |line|
          if line.match(/\d\./)
            @card = Card.new
            @card.number = line.sub(/\./, "").chomp
          elsif line.match(/\p{blank}*英語名：/)
            @card.name = line.sub(/\p{blank}*英語名：/, "").chomp
          elsif line.match(/\p{blank}*日本語名：/)
            @card.name_ja = line.sub(/\p{blank}*日本語名：/, "").sub(/（.*/, "").chomp
          elsif line.match(/\p{blank}*コスト：/)
            @card.cost = line.sub(/\p{blank}*コスト：/, "").chomp
          elsif line.match(/\p{blank}*タイプ：/)
            @card.types = line.sub(/\p{blank}*タイプ：/, "").sub(/\s+---.*/, "").chomp
            if @card.types == "クリーチャー"
              creature_types = []
              line.match(/\p{blank}*タイプ：クリーチャー --- (.+)/)[1].split("・").each do |type|
                creature_types << type.sub(/\(.+\)/, "")
              end
              @card.creature_type = creature_types.join(", ")
            end
          elsif line.match(/\p{blank}*Ｐ／Ｔ：/)
            @card.power = line.sub(/\p{blank}*Ｐ／Ｔ：/, "").split("\/")[0].chomp
            @card.toughness = line.sub(/\p{blank}*Ｐ／Ｔ：/, "").split("\/")[1].chomp
          elsif line.match(/\p{blank}*イラスト：/)
            @card.artist = line.sub(/\p{blank}*イラスト：/, "").chomp
          elsif line.match(/\p{blank}*セット：/)
            @card.expansion = line.sub(/\p{blank}*セット：/, "").chomp
          elsif line.match(/\p{blank}*稀少度：/)
            case (line.sub(/\p{blank}*稀少度：/, "").chomp)
              when "神話レア" then @card.rarity = 0
              when "レア" then @card.rarity = 1
              when "アンコモン" then @card.rarity = 2
              else @card.rarity = 3
            end
            @card.save!
            count += 1
          end
        end
      end
      flash[:notice] = "#{count}枚インポートしました"
      redirect_to cards_path
    rescue => e
      flash[:error] = "エラーが発生しました: #{e}"
      redirect_to cards_path
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy!
    flash[:notice] = "#{@card.name_ja} を削除しました"
    redirect_to cards_path
  end

  def destroy_all
    Card.destroy_all
    flash[:notice] = "カードを全て削除しました"
    redirect_to cards_path
  end

  private 

  def card_parameters
    params.require(:card).permit(:id, :number, :name, :name_ja, :cost, :expansion, :colour, :types, :power, :toughness, :artist, :rarity)
  end

  def search_card_parameters
    params.require(:search_card).permit(:name, :expansion, :types, :rarity)
  end
end
