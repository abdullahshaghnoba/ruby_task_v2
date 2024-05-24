class BooksController < ApplicationController
    # def index 
    #     @books = Book.all
    # end
    before_action :authenticate_author!
    require 'csv'
    def index
        @filterrific = initialize_filterrific(
              Book,
              params[:filterrific]
            ) or return
            @books = if params[:filterrific].present? && (params[:filterrific][:search_query].present? || params[:filterrific][:search_release_date].present? || params[:filterrific][:search_author_name].present?)
                
                        # puts params[:filterrific]
                        @filterrific.find
                    else
                        Book.includes(:author).all
                    end
            respond_to do |format|
              format.html
              format.js
              format.csv do
                filename = ['Books', Date.today].join(' ')
                send_data Book.to_csv(@books), filename:, content_type: 'text/csv'
              end
            end
          end

    def new
        @book = Book.new
        @book.author_id = current_author.id
    end

    def create
        @book = Book.new(book_params)
        @book.author_id = current_author.id
      
        if @book.save
          redirect_to books_path
        else
            puts @book.errors.full_messages
            render :new
        end
    end

    def show
        @books = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        
        if @book.update(book_params)
            redirect_to book_path(@book)
        else
            flash[:error]   = @book.errors.full_messages
            render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end  

    private

    def book_params
        params.require(:book).permit(:title, :release_date, :author_id)
    end
end
