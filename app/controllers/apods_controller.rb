#require 'net/http'

class ApodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:gotdate].nil? || params[:gotdate].empty?
      @ddate = Date.today.strftime('%d/%m/%Y')
      @url = "https://api.nasa.gov/planetary/apod?api_key=#{ENV['API_KEY']}"
    else
      @ddate = params[:gotdate]
      @url = "https://api.nasa.gov/planetary/apod?date=#{params[:gotdate]}&api_key=#{ENV['API_KEY']}"
    end
    if current_user.nil?
      @apods = Apod.limit(3).order("RANDOM()")
    else
      @apods = Apod.where('user_id = ?', current_user)
    end
  end

  def new
    @apod = Apod.new
    fill_fields(params[:nurl])
    # @result is visible
  end

  def create
    @apod = Apod.new(set_parms)
    @apod.user = current_user
    if @apod.save
      redirect_to apod_path(@apod)
    else
      render :new
    end
  end

  def show
    @apod = Apod.find(params[:id])
  end

  private

  def set_parms
    params.require(:apod).permit!
  end

  def fill_fields(url)
    @result = JSON.parse Net::HTTP.get(URI(url))
    @apod[:copyright] = @result['copyright']
    @apod[:title] = @result['title']
    @apod[:date] = @result['date'].to_date
    @apod[:explan] = @result['explanation']
    @apod[:url] = @result['url']
    @apod[:hdurl] = @result['hdurl']
    @apod[:media_type] = @result['media_type']
    #resp = Net::HTTP.get_response(URI.parse(url))
    #data = resp.body
    #@result = JSON.parse(data)
  end
end
