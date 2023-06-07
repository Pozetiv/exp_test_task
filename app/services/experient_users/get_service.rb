module ExperientUsers
  class GetService < BaseService
    class Contract < Dry::Validation::Contract
      params do
        required(:user).filled(type?: User)
      end
    end

    def call
      value = if user_expirense # if present in db return or either create new record
                { user_expirense.experiment.name => user_expirense.current_value }
              else
                return unless select_expirence

                user_exp_value = select_value_user_experiment
                user_exp = @user.build_experient_user(experiment: select_expirence, current_value: user_exp_value)
                user_exp.save
                { select_expirence.name => user_exp_value }
              end

      Success(value)
    end

    def user_expirense
      @user_expirense ||= @user.experient_user
    end

    def select_value_user_experiment
      return select_expirence.conditions.keys.first if count_by_value.blank? # first user in expirence

      current_value = select_expirence.conditions.keys.first
      min_disbalance_value = select_expirence.conditions.values.first

      select_expirence.conditions.each do |value, procent|
        new_count_for_value = count_by_value[value].to_i + 1
        new_proce = new_count_for_value / (select_expirence.experient_users_count + 1).to_f * 100
        difference = (procent - new_proce).abs

        if difference <= min_disbalance_value.to_f
          current_value = value
          min_disbalance_value = difference
        end
      end

      current_value
    end

    def last_exp
      @last_exp ||= ExperientUser.last&.experiment
    end

    def select_expirence
      return @select_expirence if @select_expirence

      return @select_expirence = Experiment.where('created_at <= ?', @user.created_at).first unless last_exp # case when started experiment

      @select_expirence = Experiment.where('created_at <= ?', @user.created_at).find_by(id: last_exp.id + 1).presence || Experiment.where('created_at <= ?', @user.created_at).first
    end

    def count_by_value
      @count_by_value ||= ExperientUser.where(experiment_id: select_expirence.id).group(:current_value).count
    end
  end
end
