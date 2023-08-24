module ApplicationHelper

  def users_verb(count)
    count == 1 ? "is" : "are"
  end

end
