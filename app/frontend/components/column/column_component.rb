module ColumnComponent
  extend ComponentHelper
  property :size, required: true

  def size_class
    "column-#{@size}"
  end
end
