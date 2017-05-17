class ApodsController < ApplicationController
  def index
    @apods = Apod.all
  end
end
