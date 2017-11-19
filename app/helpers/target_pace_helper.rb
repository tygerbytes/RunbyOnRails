require 'runby_pace'

module TargetPaceHelper

  @runs = Runby::RunTypes

  def self.all_run_types
    run_types = []
    @runs.all.each do |run_type|
      run_types << [@runs.new_from_name(run_type).description, run_type]
    end
    run_types
  end

  def self.run_type_explanations
    explanations = ''
    @runs.all.each do |run_type|
      explanations << "\"#{run_type}\": \"#{@runs.new_from_name(run_type).explanation.tr('"', '') }\",\n"
    end
    explanations
  end
end
