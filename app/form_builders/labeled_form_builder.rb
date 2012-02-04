class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field password_field email_field text_area collection_select file_field].each do |method_name|
    define_method(method_name) do |name, *args|
      @template.content_tag :div, class: "field" do
        field_label(name, *args) + super(name, *args)
      end
    end
  end

  def field_label(name, *args)
    options = args.extract_options!
    label(name, options[:label])
  end

  def objectify_options(options)
    options.except(:label)
  end

  def error_messages
    if object.errors.any?
      object.errors.full_messages.sum do |error_message|
        @template.content_tag(:p, error_message.html_safe, :class => "error")
      end
    end
  end

  def custom_error_messages
    if object.errors.any?
      object.errors.values.flatten.sum do |error_message|
        @template.content_tag(:p, error_message.html_safe, :class => "error")
      end
    end
  end
end
