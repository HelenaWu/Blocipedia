class WikiPolicy < ApplicationPolicy

  def show?
    if record.level == 'private' && record.user_id.to_i != user.id.to_i
      false
    else
      true
    end
  end

end