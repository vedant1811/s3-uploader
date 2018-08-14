require 'test_helper'

class AssetsControllerTest < ActionDispatch::IntegrationTest
  test 'should create upload_url on create' do
    asset_url_creator = Minitest::Mock.new
    asset_url_creator.expect :upload_url, 'upload_url'

    AssetUrlCreator.stub :new, asset_url_creator do
      assert_difference 'Asset.count' do
        post assets_url
      end
    end

    assert_mock asset_url_creator
    assert_response :created
  end
end
