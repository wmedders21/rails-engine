class ErrorSerializer
  def self.format_error
    { data: { error: "error" } }
  end

  def self.value_error
    format_error[:data]
  end
end
