require 'test_helper'

class AssetTest < ActiveSupport::TestCase
  test 'should create with default status' do
    asset = Asset.new
    assert asset.save
    assert asset.uploading?
  end
end
