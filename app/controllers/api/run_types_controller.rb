module API

  require 'api/api_response_boiler_plate'

  class RunTypesController < ApplicationController
    class RunTypesResponse < ApiResponseBase
      attr_reader :run_types
      def initialize(run_types)
        super()
        @run_types = run_types
      end
    end

    def index
      response = RunTypesResponse.new(Runby::RunTypes.all)
      render json: response, status: 200
    end
  end
end
