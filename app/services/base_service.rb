class BaseService
  include Dry::Monads[:result, :do]

  def self.call(params = {})
    new.send(:process, params)
  end


  private

  def process(params = {})
    yield validate_by_dry(params)
    call
  end

  def call
    raise 'Main method for service'
  end

  def validate_by_dry(params)
    if params.present?
      validate_schema = contract_name.new.call(params)

      return Failure(validate_schema.errors.to_h) unless validate_schema.success?
    end

    initialize_instance_variable(params)
    Success(params)
  end

  def contract_name
    self.class::Contract
  end

  def initialize_instance_variable(params)
    params.each do |var_name, var_value|
      self.class.send(:attr_reader, var_name)
      instance_variable_set("@#{var_name}", var_value)
    end
  end
end
