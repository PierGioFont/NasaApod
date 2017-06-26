class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @apods = Apod.limit(1).order("RANDOM()")
  end

  def index
    byebug
  end
end
