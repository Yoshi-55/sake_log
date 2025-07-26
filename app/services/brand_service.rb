require "net/http"
require "uri"
require "json"

class BrandService
  API_URL = "https://muro.sakenowa.com/sakenowa-data/api/brands"

  def self.fetch_brands
    url = URI.parse(API_URL)
    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data["brands"].map { |b| [ b["name"], b["name"] ] }
    else
      []
    end
  rescue StandardError => e
    Rails.logger.error "Failed to fetch brands: #{e.message}"
    []
  end
end
