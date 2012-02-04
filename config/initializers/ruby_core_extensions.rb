class Array
  def except(*elements)
    reject { |element| element.in? elements.flatten }
  end
end
