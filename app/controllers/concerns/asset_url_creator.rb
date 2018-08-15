
# pirated from https://pawelurbanek.com/rails-secure-s3-uploads
class AssetUrlCreator
  def initialize
    config = Rails.configuration.s3_credentials
    credentials = {
      aws_access_key_id: config['aws_access_key_id'],
      aws_secret_access_key: config['aws_secret_access_key'],
      region: config['region'],
    }

    @client = Fog::Storage::AWS.new(credentials)
    @bucket_name = config['bucket_name']
  end

  def upload_url(file_name)
    @client.put_object_url(
          @bucket_name,
          file_path(file_name),
          time_to_access
        )
  end

  def download_url(file_name, timeout = nil)
    @client.get_object_url(
          @bucket_name,
          file_path(file_name),
          time_to_access
        )
  end

private
  def time_to_access(timeout_in_seconds = nil)
    timeout_in_seconds ||= Rails.configuration.s3_timeout
    timeout_in_seconds.seconds.from_now.to_i
  end

  def file_path(file_name)
    Rails.configuration.s3_path_prefix + file_name.to_s
  end
end
