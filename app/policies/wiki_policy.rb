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
    if record.private? && (record.user != user) && !(has_collaborator(user, record))
      false
    else
      true
    end
  end
  
  private
  #allows collaborator to edit wiki
  def has_collaborator(user, record)
    record.collaborators.exists?(email: user.email)
  end
end