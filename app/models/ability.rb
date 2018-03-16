class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :update, :destroy, to: :cud

    if user.admin?
      can :manage, :all
    else
      can :cud, Post, user_id: user.id
      can :cud, Comment, user_id: user.id
    end
  end
end
