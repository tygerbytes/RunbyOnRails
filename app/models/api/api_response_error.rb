module API
  class ApiResponseError < ApiResponseBase
    attr_reader :error, :usage
    def initialize(error_message, usage_message)
      super()
      @error = error_message
      @usage = usage_message
    end
  end
end
