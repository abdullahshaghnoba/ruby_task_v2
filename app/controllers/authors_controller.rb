class AuthorsController < ApplicationController
  before_action :authenticate_author!, only: [:show]
  
  def show
    @author = current_author
  end
end
