class Asset < ApplicationRecord
  enum status: [
    :uploading,
    :uploaded,
    :failed
  ]
end
