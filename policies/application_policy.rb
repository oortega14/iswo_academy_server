class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def super_admin?
    user&.is_super_admin?
  end
end
