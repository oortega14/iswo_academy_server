# Define BaseSerializer
class BaseSerializer
  attr_reader :resource, :context

  def initialize(resource, context = {})
    @resource = resource
    @context = context
  end

  def current_user
    @context[:current_user]
  end
end
