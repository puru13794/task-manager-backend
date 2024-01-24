# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json


  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        data: { code: 200, message: 'signed up sucessfully', data: resource }, status: :ok
      }
    else
      render json: {
        data: {message: 'user creation failed', errors: resource.errors.full_messages }, status: :unprocessable_entity
      }
    end
  end
end
