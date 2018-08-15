unless Rails.env.test?
  Rails.application.configure do
    config.s3_credentials = config_for(:s3_credentials)
    config.s3_timeout = 60 # always in seconds
    config.s3_path_prefix = 'vedant1811/assets/'
  end
end
