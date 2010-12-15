# coding: utf-8
require_relative "../spec_helper"
require "tsuridana/step_definitions"

describe Tsuridana::StepDefinitions do
  describe '.cucumber_keywords' do
    subject { Tsuridana::StepDefinitions.cucumber_keywords }
    it { should_not be_empty }
  end
  context ".new('spec/fixtures/cucumber_steps')" do
    before do
      @step_defs = Tsuridana::StepDefinitions.new(
        fixture('cucumber_steps.rb')
      )
      @step_defs.parse('')
    end
    subject{ @step_defs }

    it { should have(32).step_definitions }
  end

  context ".new('spec/fixtures/web_steps_ja.rb')" do
    before do
      @step_defs = Tsuridana::StepDefinitions.new(
        fixture('web_steps_ja.rb'),
        %w[前提 もし ならば かつ しかし]
      )
      @step_defs.parse('')
    end
    subject{ @step_defs }

    it { should have(34).step_definitions }
  end
end

