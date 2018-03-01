require 'interactor'
require 'virtus'
require 'active_model'

module Peafowl
  def self.included(base)
    base.class_eval do
      include ::Interactor
      include ::Virtus.model
      include ::ActiveModel::Validations

      attr_writer :context

      before do
        context.fail!(errors: errors.full_messages) unless valid?
      end

      after do
        context.fail!(errors: error_messages) if error_messages.present?
      end

      def self.call(context = {})
        instance = new(context)
        instance.context = Interactor::Context.build(context)
        instance.tap(&:run).context
      end
    end
  end

  def add_error!(messages)
    add_error(messages)
    context.fail!(errors: error_messages)
  end

  def add_error(messages)
    return error_messages.concat(messages) if messages.is_a?(Array)

    error_messages << messages
  end

  def error_messages
    @error_messages ||= []
  end
end
