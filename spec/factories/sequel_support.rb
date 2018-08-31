# frozen_string_literal: true

# Sequel support in FactoryBot

FactoryBot.define do
  to_create do |record|
    record.model.unrestrict_primary_key
    record.save
    record.model.restrict_primary_key
  end
end
