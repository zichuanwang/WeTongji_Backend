class Ability
  include CanCan::Ability

  def initialize(admin)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    admin ||= Admin.new
    case admin.role
        when "SuperAdmin"
            can :manage, :all
            
        when "CommonAdmin"
            cannot :create, Admin
            can :update, admin
            can :read, admin

            can :manage, News, :admin => { :id => admin.id }
            can :create, News
            cannot :approve, News

            can :manage, Activity, :admin => { :id => admin.id }
            can :create, Activity
            cannot :approve, Activity

            can :manage, SchoolNews if admin.has_permission("SchoolNews")
            can :create, SchoolNews
            cannot :approve, SchoolNews

            can :manage, ClubNews, :admin => { :id => admin.id } if admin.has_permission("ClubNews")
            #can :read, ClubNews, :admin => { :id => admin.id }
            can :update, ClubNews, :admin => { :id => admin.id }
            can :create, ClubNews,:admin => { :id => admin.id }
            cannot :approve, ClubNews

            can :manage, ForStaff if admin.has_permission("ForStaff")
            can :create, ForStaff
            cannot :approve, ForStaff

            can :manage, Around if admin.has_permission("Around")
            can :create, Around
            cannot :approve, Around

            can :manage, Person if admin.has_permission("Person")
            can :create, Person
            cannot :approve, Person
    end
  end
end
