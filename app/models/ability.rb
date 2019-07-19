# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user 
      begin #post section
        can :like, Post
        can [:create,:read, :like], Post
        can :destroy, Post do |post|
          post.user_id == user.id || post.parent&.user_id == user.id
        end
      end
      begin #game section
        can [:read, :create], Game
        can [:destroy, :update], Game, user_id: user.id
      end
      begin #article section 
        can [:read,:create], Article 
        can [:update,:destroy], Article do |article|
          article.writer_id == user.id || article.game.user.id == user.id
        end
      end
      begin #tag section 
        can :create, Tag
      end
      begin #order section
        can [:create,:read], Order
        can :destroy, Order do |order| order.game.user.id == user.id end
        can :approve, Order do |order| 
          order.game.user.id == user.id && !order.approved
        end
        can :see_details, Order do |order| 
          order.game.user.id == user.id 
        end
      end
      can [:read,:follow], User
    else 
      can :read, [User,Post,Game,Article]
      can [:create,:read],Order
    end
  end
end
