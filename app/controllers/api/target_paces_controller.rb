module API

  require 'api/api_response_boiler_plate'

  class TargetPacesController < ApplicationController

    class TargetPaceUsageErrorResponse < ApiResponseError
      def initialize(error)
        usage = "Provide five_k_time and run_type, like this: 'target_paces?five_k_time=21:30;run_type=LongRun'"
        super(error, usage)
      end
    end

    class TargetPaceResponse < ApiResponseBase
      attr_reader :best_five_k_time, :run_type
      attr_reader :target_pace_km, :target_pace_mi
      attr_reader :target_speed_kph, :target_speed_mph

      def initialize(pace_calculation)
        super()
        @best_five_k_time = pace_calculation.five_k_time
        @run_type = pace_calculation.run_type.description
        @target_pace_km = pace_calculation.pace_data_km
        @target_pace_mi = pace_calculation.pace_data_mi
        @target_speed_kph = pace_calculation.kph
        @target_speed_mph = pace_calculation.mph
      end
    end

    def index
      error = ''
      error = "#{error}Missing 'five_k_time';" unless params[:five_k_time]
      error = "#{error}Missing 'run_type';" unless params[:run_type]
      unless error.empty?
        render json: TargetPaceUsageErrorResponse.new(error), status: 400
        return
      end
      units = params[:units]
      pace = PaceCalcs.new.calc(params[:five_k_time], params[:run_type], units)
      target_pace = TargetPaceResponse.new pace
      render json: target_pace, status: 200
    end

  end
end


