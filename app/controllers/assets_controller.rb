class AssetsController < ApplicationController
  def create
    asset = Asset.create!
    render json: {
      upload_url: asset_url_creator.upload_url,
      id: asset.id
    }, status: :created
  end

private
  def asset_url_creator
    @_asset_url_creator ||= AssetUrlCreator.new
  end
end
