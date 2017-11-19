require 'test_helper'

class ListRunTypesTest < ActionDispatch::IntegrationTest

  setup { host! 'api.runbypace-dev.com' }

  test 'returns a JSON formatted list of all valid run types' do
    get '/run_types', headers: { accept: 'application/json' }
    assert_equal 200, response.status
    run_types = (JSON.parse response.body, symbolize_names: true)[:run_types]
    assert_includes run_types, 'LongRun'
    assert_includes run_types, 'TempoRun'
  end

  test 'the response contains our boiler plate stuff' do
    get '/run_types', headers: { accept: 'application/json' }
    assert_equal 200, response.status
    pace_response = JSON.parse response.body, symbolize_names: true
    assert_not_empty pace_response[:about]
  end

end
