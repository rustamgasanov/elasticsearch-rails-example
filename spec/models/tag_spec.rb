require 'rails_helper'

RSpec.describe Tag, :type => :model do
  it { should respond_to(:name) }
end
