class ExpansionsController < ApplicationController
  def index
    @expansions = Expansion.all.order(:released_at)
  end

  def new
    @expansion = Expansion.new
  end

  def create
    puts "expansion_parameters"
    @expansion = Expansion.new(expansion_parameters)
    @expansion.save!
    flash[:notice] = "#{@expansion.name_ja} を追加しました"
    redirect_to expansions_path
  end

  def destroy
    @expansion = Expansion.find(params[:id])
    @expansion.destroy!
    flash[:notice] = "#{@expansion.name_ja} を削除しました"
    redirect_to expansions_path
  end

  private 

  def expansion_parameters
    params.require(:expansion).permit(:id, :name, :name_ja, :abbr, :released_at)
  end
end
