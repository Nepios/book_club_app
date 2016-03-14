class BooksController < ApplicationController

  def index
    @key = ENV['GOOGLE']
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@query}&key=#{@key}"
    puts url
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @responses = HTTParty.get(url)
  end

  def show
    @id = params[:id]
    @key = ENV['GOOGLE']
    @query = params[:query]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{@id}&key=#{@key}"
    puts url
    #disables SSL for localhost, remove once deployed
    HTTParty::Basement.default_options.update(verify: false)
    @response = HTTParty.get(url)
    @book = Book.new
  end

  def new
    @book = Book.new 
  end

  def create
    book_new = Book.find_or_create_by(isbn: params[:books][:id]) do |book|
      book.title = params[:books][:title]
      book.author = params[:books][:author]
      book.isbn = params[:books][:id]
      book.yearofpub = params[:books][:date]
      book.description = params[:books][:description]
      book.image = params[:books][:image]
      book.category = params[:books][:category]
    end
    redirect_to root_path
  end

end


