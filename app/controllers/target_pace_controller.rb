require 'pace_calcs'

class TargetPaceController < ApplicationController

  def index
    @activated_toggles = []
    @units = 'imperial'
    @active_nav = 'index'
  end

  def calc
    respond_to do |format|
      @units = 'imperial'
      @pace = PaceCalcs.new.calc(params[:five_k_time], params[:run_type], @units)
      @activated_toggles = params[:activated_toggles].split(';')
      format.html
      format.js
    end
  end
end
