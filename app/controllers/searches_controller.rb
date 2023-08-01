class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]

    if @model == "User"
      @records = User.search_for(params[:method], params[:content])
    elsif @model == "Book"
      @records = Book.search_for(params[:method], params[:content])
    end
  end
end
