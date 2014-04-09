require 'spec_helper'

describe Schedule do
  it { should validate_presence_of :schedule }
  it { should belong_to :user}
end
