class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    # 選択したモデルに応じて検索を実行
    if @model  == "user"
      @records = User.search_for(@content, @method)
    elsif @model == "address"
      @records = Post.a_search_for(@content)
    else
      @records = Post.c_search_for(@content)
    end
  end
end
