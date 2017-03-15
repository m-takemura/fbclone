module TopicsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      return 'back'
    elsif action_name =='edit'
      return ''
    end
  end

  def show_form?
    if action_name == 'show'
      return true
    else
      return false
    end
  end
end
