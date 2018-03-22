class Api::TripsController < Api::BaseController
  before_action :doorkeeper_authorize!
  load_and_authorize_resource
  
  def index
    @trips = []
    if current_api_user
      if current_api_user.company
        @trips = current_api_user.company.trips # Returning records of company belonging to user
      end
      if params[:start_time] && params[:end_time]
        @trips = @trips.where("start_time >= ? OR ? <= end_time", params[:start_time], params[:end_time])
        @trips = @trips.filter_by_vehicle(params[:vehicle]) if params[:vehicle].present?
        @trips = @trips.filter_by_user(params[:user]) if params[:user].present?
        
        render json: @trips
      else
        render json: {error: "invalid_params", error_description: "Missing params"}, status: :bad_request
      end
    else
      render json: {error: "unauthorized", error_description: "User is not authenticated"}, status: :bad_request
    end
  end
  
  def create
    trips = trip_params
    if trips.present?
      begin 
        ActiveRecord::Base.transaction do
        trips[:trips].each do |trip|
          @trip_record = Trip.new
          @trip_record.vehicle_id =  trip[:vehicle_id] if trip[:vehicle_id]
          @trip_record.company_id = trip[:company_id] if trip[:company_id]
          @trip_record.user_id = trip[:user_id] if trip[:user_id]
          @trip_record.start_time = trip[:start_time] if trip[:start_time]
          @trip_record.end_time = trip[:end_time] if trip[:end_time]
          @trip_record.distance = trip[:distance] if trip[:distance]
          @trip_record.save!          
          end
        end
        render json: {message: "Record created from given array of trips"}, status: :created
      rescue => e
        render json: {error: "invalid_recrod", error_description: e}, status: :bad_request
      end
    else
      render json: {error: "invalid_params", error_description: "Missing params"}, status: :bad_request
    end
  end
  
  def trips_summary
    @trips = []
    if params[:vehicle_id].present?
      vehicle = Vehicle.find_by_id(params[:vehicle_id])
      if !vehicle.nil?
        @trips = vehicle.trips
        if @trips.present?
          @total_distance = @trips.all.pluck(:distance).map(&:to_i).reduce(0, :+)
          render json: {message: @total_distance.to_s }, status: :ok
        else
          render json: {error: "trips not present for given vehicle"}, status: :bad_request
        end
      else
        render json: {error: "invalid_params", error_description: "Missing params"}, status: :bad_request
      end
    elsif params[:user_id].present?
      user = User.find_by_id(params[:user_id])
      if !user.nil?
        @trips = user.trips
        if @trips.present?
          @total_distance = @trips.all.pluck(:distance).map(&:to_i).reduce(0, :+)
          render json: {total_distance: @total_distance}, status: :ok
        else
          render json: {error: "trips not present for given user"}, status: :bad_request
        end
      else
        render json: {error: "invalid_params", error_description: "Missing params"}, status: :bad_request
      end
    else
      render json: {error: "invalid_params", error_description: "Missing params"}, status: :bad_request
    end
    
  end
  private
    def trip_params
      params.permit(trips: [:vehicle_id, :company_id, :user_id, :start_time, :end_time, :distance])
    end
end
