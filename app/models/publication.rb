class Publication < ApplicationRecord
  belongs_to :serial

  has_one :amazon_item_attribute
end
