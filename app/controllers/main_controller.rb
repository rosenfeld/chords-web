require 'open-uri'
require 'json'

class MainController < ApplicationController
  def index
    @index_path = params[:index_path] || 'https://raw.github.com/rosenfeld/harmonias/master/.index.json'
  end

  def show
    @content = read_url(params[:song_path])
  end

  def fetch
    render json: fetch_index(params[:index_path])
  end

  private

  def read_url(path)
    open(URI.escape path).read.force_encoding 'utf-8'
  end

  def fetch_index(path)
    base = path.sub(/(.*\/).*\z/, '\\1')
    JSON.parse(read_url path).map do |entry|
      entry['path'] = "#{base}#{entry['path']}" unless entry['path'] =~ /\Ahttps?\:\/\//
      entry
    end
  end
end
