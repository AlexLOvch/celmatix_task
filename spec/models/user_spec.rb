# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(8).with_message(/is too short/) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
end
