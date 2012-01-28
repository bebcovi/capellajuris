class ExtendedFormBuilder < ActionView::Helpers::FormBuilder
  def error_messages
    if object.errors.any?
      object.errors.full_messages.sum do |error_message|
        @template.content_tag(:p, "#{error_message}", class: "error")
      end
    end
  end

  def custom_error_messages
    if object.errors.any?
      object.errors.values.flatten.sum do |error_message|
        @template.content_tag(:p, "#{error_message}", class: "error")
      end
    end
  end
end
