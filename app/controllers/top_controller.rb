class TopController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :guide, :howto ]
end
