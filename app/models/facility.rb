class Facility < ApplicationRecord
    has_many :checks, dependent: :destroy
end
