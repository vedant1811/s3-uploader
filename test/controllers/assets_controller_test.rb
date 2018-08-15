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

  test 'should update status on update' do
    asset = assets :two
    assert asset.uploading?

    put asset_url asset, status: 'uploaded'
    assert_response :no_content
    assert asset.reload.uploaded?
  end

  test 'should render error on incorrect status' do
    asset = assets :two
    assert asset.uploading?

    put asset_url asset, status: 'uploading'
    assert_response :bad_request
    assert asset.reload.uploading?
  end
end
