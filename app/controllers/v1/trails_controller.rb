class V1::TrailsController < ApplicationController
  def index 
    trails = Trail.all

    if trails.empty?
      render_error_message('No trails here, turn around.', 400)
    else
      render json: trails
    end
  end

  def create
    trail = Trail.create(trail_params)

    if trail.persisted?
      render json: {message: 'Trail was successfully created'}
    else 
      render_error_message('Please add content to all fields', 400)
    end   
  end

  private

  def trail_params
    params.permit(:title, :description, :intensity, :extra, :duration, :location)
  end

  def render_error_message(message, status) 
    render json: { error_message: message }, status: status
  end
end