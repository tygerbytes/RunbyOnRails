require 'runby_pace'

class TargetPaceData
  attr_reader :five_k_time, :run_type, :pace_data_km, :pace_data_mi, :kph, :mph

  def initialize(five_k_time, run_type, pace_data_km, pace_data_mi, kph, mph)
    @five_k_time = five_k_time
    @run_type = run_type
    @pace_data_km = pace_data_km
    @pace_data_mi = pace_data_mi
    @kph = kph
    @mph = mph
  end
end

class PaceCalcs
  def calc(five_k_time, run_type, units)
    run_type = Runby::RunTypes.new_from_name(run_type)
    pace_data_km = run_type.lookup_pace(five_k_time, :km)
    pace_data_mi = run_type.lookup_pace(five_k_time, :mi)

    speed_kph = pace_data_km.as_speed_range.to_s
    speed_mph = pace_data_mi.as_speed_range.to_s

    five_k_time_formatted = Runby::RunbyTime.new(five_k_time).to_s
    @pace = TargetPaceData.new(five_k_time_formatted, run_type, pace_data_km.to_s, pace_data_mi.to_s, speed_kph, speed_mph)
  end

  private

  def get_distance_units(units)
    case units
      when 'imperial' then :mi
      when 'metric' then :km
      else :km
    end
  end

end