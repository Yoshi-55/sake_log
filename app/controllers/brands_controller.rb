# require 'net/http'
# require 'json'

# class BrandsController < ApplicationController
#   def index
#     url = URI.parse("https://muro.sakenowa.com/sakenowa-data/api/brands")
#     response = Net::HTTP.get_response(url)

#     if response.is_a?(Net::HTTPSuccess)
#       data = JSON.parse(response.body)
#       @brands = data["brands"]
#     else
#       @brands = []
#       flash[:alert] = "銘柄データの取得に失敗しました"
#     end
#   end
# end

