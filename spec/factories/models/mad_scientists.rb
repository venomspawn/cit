# frozen_string_literal: true

FactoryBot.define do
  factory :mad_scientist, class: CIT::Models::MadScientist do
    id         { create(:uuid) }
    name       { create(:string) }
    madness    { create(:integer) }
    tries      { create(:integer) }
    created_at { Time.now }
  end
end
