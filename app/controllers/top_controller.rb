class TopController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :guide, :howto ]

  def index
  end

  def guide
  end

  def howto
  end
end
