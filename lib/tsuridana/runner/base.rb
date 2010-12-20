# coding: utf-8
require 'tsuridana/step_definitions'

module Tsuridana
  module Runner
    class Base
      def self.run(*files)
        files.each{|f| new(f).display }
      end

      def initialize(src)
        @step_definitions = Tsuridana::StepDefinitions.new(src)
      end

      def steps
        unless @parsed
          @step_definitions.parse('')
          @parsed = true
        end
        @step_definitions.step_definitions
      end
    end
  end
end

