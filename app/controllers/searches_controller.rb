class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @model = params[:model]

    if @model == "User"
      @records = User.search_for(params[:method], params[:content])
    elsif @model == "Book"
      @records = Book.search_for(params[:method], params[:content])
    elsif @model == "Tag"
      @records = Book.search_tag_for(params[:content])
    end
  end
end
