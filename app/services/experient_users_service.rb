class ExperientUsersService < BaseService
  class Contract < Dry::Validation::Contract
    params do
      required(:user).filled(type?: User)
    end
  end

  def call
    return Success(find_in_redis.entries) if find_in_redis.entries.present?
    return Success() if Experiment.where('created_at <= ?', @user.created_at).blank?

    value = ExperientUsers::GetService.call(user: @user)
    find_in_redis.update(**value.success)
    Success(value.success)
  end

  def find_in_redis
    @find ||= Kredis.hash("ausers_experiens_data_#{@user.id}")
  end
end
