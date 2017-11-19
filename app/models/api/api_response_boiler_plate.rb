module API

  # A class that should be included in all of our API responses.
  # Contains useful info like the api version and the UTC timestamp
  module ResponseBoilerPlate
    attr_reader :about
    def initialize
      @about = BoilerPlate.new
    end

    private
    class BoilerPlate
      attr_reader :api_version, :legal, :time_stamp_utc
      def initialize
        @legal = 'RunbyPace (c)2017. By Ty Walls. https://runbypace.com'
        @api_version = 'v1'
        @time_stamp_utc = Time.now.utc
      end
    end
  end
end
