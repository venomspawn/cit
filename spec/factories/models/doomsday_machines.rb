# frozen_string_literal: true

FactoryBot.define do
  factory :doomsday_machine, class: CIT::Models::DoomsdayMachine do
    id               { create(:uuid) }
    name             { create(:string) }
    power            { create(:integer) }
    created_at       { Time.now }
    mad_scientist_id { create(:mad_scientist).id }
  end
end
