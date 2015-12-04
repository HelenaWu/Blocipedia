class WikiPolicy < ApplicationPolicy

  def edit?
    @user.present? && (record.user == @user || @user.admin? || has_collaborator(user, record))
  end
  def update?
    edit?
  end
  def destroy?
    @user.present? && (record.user == @user)
  end
  def show?
    if record.private? && (record.user != user)
      false
    else
      true
    end
  end
  
  private
  #allows collaborator to edit wiki
  def has_collaborator(user, record)
    record.collaborators.each do |c| 
      if c.email = user.email
        return true
      end
    end
    return false
  end
end