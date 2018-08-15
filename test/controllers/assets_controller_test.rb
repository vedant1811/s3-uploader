require 'test_helper'

class AssetsControllerTest < ActionDispatch::IntegrationTest
  test 'should create upload_url on create' do
    asset_url_creator = Minitest::Mock.new
    asset_url_creator.expect :upload_url, 'url'

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

  test 'should render error on show uploading asset' do
    asset = assets :two
    assert asset.uploading?

    get asset_url asset, status: 'uploading'
    assert_response :bad_request
  end

  test 'should create upload_url on show' do
    asset = assets :one
    asset_url_creator = Minitest::Mock.new
    asset_url_creator.expect :download_url, 'url', [asset.id]

    AssetUrlCreator.stub :new, asset_url_creator do
      get asset_url asset
    end

    assert_mock asset_url_creator
    assert_response :ok
  end

  test 'should create upload_url with timeout on show' do
    asset = assets :one
    timeout = 100
    asset_url_creator = Minitest::Mock.new
    asset_url_creator.expect :download_url, 'url', [asset.id, timeout]

    AssetUrlCreator.stub :new, asset_url_creator do
      get asset_url asset, timeout: timeout
    end

    assert_mock asset_url_creator
    assert_response :ok
  end
end
