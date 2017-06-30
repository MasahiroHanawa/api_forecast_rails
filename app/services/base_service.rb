class BaseService < Reform::Form
  class ParametersInvalid < StandardError; end

  # NOTE `new(Model.new)` 等のようにしてインスタンスを生成して返すようにしてください
  def self.build
    raise NotImplementedError
  end

  def run(params = {})
    if validate(params)
      perform

      yield @model if block_given?
      return true
    end

    false
  end

  def run!(params = {}, &block)
    unless run(params, &block)
      raise ParametersInvalid, I18n.t('errors.messages.record_invalid', errors: errors.full_messages.join(', '))
    end
  end

  private

  def perform
    raise NotImplementedError
  end
end