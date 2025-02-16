attr_reader :user, :record

def initialize(user, record)
  raise Pundit::NotAuthorizedError unless user

  @user   = user
  @record = record
end

# Application Policy Scope
class Scope
  attr_reader :user, :scope

  def initialize(user, scope)
    raise Pundit::NotAuthorizedError unless user

    @user = user
    @scope = scope
  end
end
