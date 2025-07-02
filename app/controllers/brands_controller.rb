require "net/http"

class BrandsController < ApplicationController
  def proxy
    uri = URI("https://muro.sakenowa.com/sakenowa-data/api/brands")
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
  end
end
