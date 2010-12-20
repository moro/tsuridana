# coding: utf-8
require 'tsuridana/runner/base'

module Tsuridana
  module Runner
    class Unite < Base
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
