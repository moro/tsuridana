# coding: utf-8
require 'tsuridana/step_definitions'

module Tsuridana
  module Runner
    class Unite
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

      def display
        steps.each do |step|
          puts "#{filter(step.re_src)}\t#{@step_definitions.src}\t#{step.lino}"
        end
      end

      private
      def filter(re_src)
        re_src.sub(/^\^(.+)\$$/, '\1')
      end
    end
  end
end
