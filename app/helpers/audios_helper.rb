module AudiosHelper
  def display_errors(errors)
    if errors.present?
      errors.sum do |error|
        content_tag :p, error, :class => "error"
      end
    end
  end
end
