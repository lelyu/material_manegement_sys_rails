class HomeController < ApplicationController
  def index
  end

  def about
    @about_me = "**Hello from the about controller**"
  end
end
