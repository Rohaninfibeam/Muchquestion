module ApplicationHelper
  class ActionView::Helpers::FormBuilder
    def error_message_for(field_name)
      if self.object.errors[field_name].present?
        model_name              = self.object.class.name.downcase
        id_of_element           = "error_#{model_name}_#{field_name}"
        class_name              = 'signup-error alert alert-danger'

        "<div id=\"#{id_of_element}\" class=\"#{class_name}\">"\
        "#{self.object.errors[field_name].join(', ')}"\
        "</div>".html_safe
      end
    rescue
      nil
    end
end
end
