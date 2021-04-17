class Cost < ApplicationRecord
  belongs_to :pet
  enum cost_type: [:local, :national, :international]
end
