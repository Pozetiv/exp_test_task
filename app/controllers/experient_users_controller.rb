class ExperientUsersController < ApplicationController
  def index
    @experiments = Experiment.all
    @experient_users = ExperientUser.all.includes(:user, :experiment).paginate(page: params[:page])
  end
end
