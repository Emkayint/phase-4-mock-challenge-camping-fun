class SignupsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessed_entity_response

  def index
    signups = Signup.all
    render json: signups, status: :ok
  end

  def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
  end

  def show
    signup = Signup.find(params[:id])
    render json: signup, status: :ok
  end

  private

  def signup_params
    params.permit(:camper_id, :time, :activity_id)
  end

  def render_unprocessed_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: 'Signup not found' }, status: :not_found
  end
end
