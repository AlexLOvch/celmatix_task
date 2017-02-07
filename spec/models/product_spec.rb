# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to(:brand) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_length_of(:model).is_at_most(255) }
  it { is_expected.to validate_presence_of(:sku) }
  it { is_expected.to validate_length_of(:sku).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:sku) }
  it { is_expected.to validate_presence_of(:sku) }
end
