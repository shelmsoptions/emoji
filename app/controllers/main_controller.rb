require 'json'
require 'net/http' #to make a GET request
require 'open-uri' #to fetch the data from the URL to then be parsed by JSON

class MainController < ApplicationController
  $emoji_uri = "https://api.github.com/emojis"

  def index
    puts 'in index method'
    puts session[:input_state]
  end

  def get_api
    puts 'in get_api method'
    puts session[:input_state]
    uri = URI.parse($emoji_uri)
    http = Net::HTTP.new(uri.host, uri.port)
        #to be able to access https URL, these line should be added
        #github api has an https URL
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
        #store the body of the requested URI (Uniform Resource Identifier)
    data = response.body
        #to parse JSON string; you may also use JSON.parse()
        #JSON.load() turns the data into a hash
    @emoji = JSON.load(data)
    # puts @emoji
    if @emoji.include?(session[:input_state])
      puts 'match found'
    else
      # puts 'no match found'
      flash[:error] = "Sorry.  Interpreter couldn\'t interpret based on data provided"
      redirect_to '/'
    end

        # VV To see what's being gathered by the Rails project,
        # VV   you may replace the line @emoji= JSON.load(data) with a render :text line.  VV
        #  render :text => data
  end

  def create
    session[:input_state] = params[:mood_state]
    redirect_to '/interpretation'
  end

  def back
    session[:input_state] = nil
    redirect_to root_url
  end
end