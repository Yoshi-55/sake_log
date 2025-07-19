class BrandsController < ApplicationController
  def proxy
    brands_data = BrandService.fetch_brands
    brands_response = { "brands" => brands_data.map { |name, _| { "name" => name } } }
    render json: brands_response
  end
end
