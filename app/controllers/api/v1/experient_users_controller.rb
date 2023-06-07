module Api
  module V1
    class ExperientUsersController < ApplicationController
      def create
        result = ExperientUsersService.call(user: current_user)
        render json: result.success, status: :ok
      end
    end
  end
end
