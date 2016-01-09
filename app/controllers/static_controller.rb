require 'json'
require 'open-uri'

class StaticController < ApplicationController
  def index
  end

  def celebrate
    word = ActionController::Base.helpers.sanitize(params[:text]) || ''
    @response = ':tada:'
    @response += word.chars.map{ |ch| ch + ':tada:' }.join
    respond_to do |format|
      format.html
      format.json
    end
  end

  def pugbomb
    pug_count = params[:text] ? params[:text].to_i : 1
    @pugs = []
    @response = pug_count > 1 ? "PUG BOMB! Here are your #{pug_count} pugs" : "Here's a pug for you"
    if pug_count < 1
      @response = "You need at least one pug. " + @response
      pug_count = 1
    end

    if pug_count > 100
      @response = "That's a lot of pugs. Here's one"
      pug_count = 1
    end

    pug_count.times do
      begin
        response = JSON.load(open('http://pugme.herokuapp.com/random'))
        @pugs << response['pug']
      rescue
        # just keep going
      end
    end

    respond_to do |format|
      format.html
      format.json
    end
  end
end
