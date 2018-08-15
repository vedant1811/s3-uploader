class AssetController < ApplicationController
  before_action :set_asset, only: [:update, :show]

  def create
    asset = Asset.create!
    render json: {
      upload_url: asset_url_creator.upload_url(asset.id),
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

  def show
    if @asset.uploaded?
      render json: {
        download_url: asset_url_creator.download_url(*download_url_params)
      }
    else
      render json: {
        error: "Cannot get url for status: #{@asset.status}"
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

  def download_url_params
    [@asset.id, params[:timeout]&.to_i].compact
  end
end
