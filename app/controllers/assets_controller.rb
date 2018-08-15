class AssetsController < ApplicationController
  before_action :set_asset, only: [:update, :show]

  def create
    asset = Asset.create!
    render json: {
      upload_url: asset_url_creator.upload_url,
      id: asset.id
    }, status: :created
  end

  def update
    if params[:status] == 'uploaded'
      @asset.uploaded!
      head :no_content
    else
      render json: {
        error: "Cannot handle status: #{params[:status]}"
      }, status: :bad_request
    end
  end

private
  def asset_url_creator
    @_asset_url_creator ||= AssetUrlCreator.new
  end

  def set_asset
    @asset = Asset.find params[:id]
  end
end
