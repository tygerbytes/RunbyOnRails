require 'test_helper'

class LookupTargetPaceTest < ActionDispatch::IntegrationTest

  setup { host! 'api.runbypace-dev.com' }

  test 'looks up a target pace and returns it, formatted as JSON' do
    get '/target_paces',
        params: { five_k_time: '21:30', run_type: 'EasyRun' },
        headers: { accept: 'application/json' }
    assert_equal 200, response.status
    pace_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal '21:30', pace_response[:best_five_k_time]
    assert_equal '6:14-7:14 p/km', pace_response[:target_pace_km]
    assert_equal '9.63-8.29 km/ph', pace_response[:target_speed_kph]
  end

  test 'the response contains our boiler plate stuff' do
    get '/target_paces',
        params: { five_k_time: '21:30', run_type: 'EasyRun' },
        headers: { accept: 'application/json' }
    assert_equal 200, response.status
    pace_response = JSON.parse(response.body, symbolize_names: true)
    boiler_plate = pace_response[:about]
    assert_equal 'RunbyPace (c)2017. By Ty Walls. https://runbypace.com', boiler_plate[:legal]
    assert_equal 'v1', boiler_plate[:api_version]
    assert_not_empty boiler_plate[:time_stamp_utc]
  end

  test 'an error response is returned if the request is missing necessary parameters' do
    get '/target_paces'
    assert_equal 400, response.status
  end

  test 'the error message specifies what is missing' do
    get '/target_paces'
    error_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Missing 'five_k_time';Missing 'run_type';", error_response[:error]
  end

  test 'the error response contains helpful usage information' do
    get '/target_paces'
    error_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Provide five_k_time and run_type, like this: 'target_paces?five_k_time=21:30;run_type=LongRun'", error_response[:usage]
  end

end
