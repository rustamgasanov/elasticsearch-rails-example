require 'rails_helper'

RSpec.describe Article, :type => :model do
  it { should respond_to(:title) }
  it { should respond_to(:content) }
end
