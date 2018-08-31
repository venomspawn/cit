# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:mad_scientists) do
      column :id,         :uuid, primary_key: true
      column :name,       :text, null: false
      column :madness,    :integer, null: false, default: 0
      column :tries,      :integer, null: false, default: 0
      column :created_at, :timestamp, null: false

      constraint(:mad_scientists_madness_non_negativeness) { madness >= 0 }
      constraint(:mad_scientists_tries_non_negativeness) { tries >= 0 }
    end
  end
end
