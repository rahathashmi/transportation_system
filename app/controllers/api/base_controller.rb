class Api::BaseController < ApplicationController
  respond_to :json
  include CanCan::ControllerAdditions
end
