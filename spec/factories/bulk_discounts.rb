FactoryBot.define do
  factory :bulk_discount do
    merchant { nil }
    quantity_threshold { 1 }
    percentage { 1 }
  end
end
