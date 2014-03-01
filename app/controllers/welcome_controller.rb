class WelcomeController < ApplicationController
  def index
    @upload = Photo.new
  end
end
