class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed_entity_response


  def index
    activity = Activity.all
    render json: activity, status: :ok
  end

  def create
    activity = Activity.create(activity_params)
    render json: activity, status: :created
  end

  def destroy
    activity = Activity.find(params[:id])
    activity.destroy
    head :no_content
  end

  def show
    activity = Activity.find(params[:id])
    render json: activity, status: :ok
  end

  private

  def activity_params
    params.permit(:name, :difficulty)
  end
  def render_unprocessed_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: 'Activity not found' }, status: :not_found
  end
end
