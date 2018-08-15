require 'test_helper'

class AssetActionsTest < ActionDispatch::IntegrationTest
  test 'full flow of a new asset' do
    # create
    post '/asset'
    assert_response :created
    response_json = JSON.parse response.body
    asset_id = response_json['id'].to_i
    refute_empty response_json['upload_url']
    refute_equal 0, asset_id

    # update
    put "/asset/#{asset_id}", params: '{"status": "uploaded"}', headers: { 'Content-Type' => 'application/json' }
    assert_response :no_content

    # show
    get "/asset/#{asset_id}"
    assert_response :ok
    response_json = JSON.parse response.body
    refute_empty response_json['download_url']
  end
end
