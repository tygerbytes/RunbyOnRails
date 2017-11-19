module ApplicationHelper
  def class_list_if(condition, class_list)
    if condition
      " class=#{class_list} "
    end
  end
end
