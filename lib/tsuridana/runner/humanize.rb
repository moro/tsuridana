# coding: utf-8
require 'tsuridana/runner/base'
begin
  require 'term/ansicolor'
rescue LoadError => ignore
end

module Tsuridana
  module Runner
    class Humanize < Base
      def display
        steps.each do |step|
          puts "#{coloize(step.re_src)}\t#{@step_definitions.src}:#{step.lino}"
        end
      end

      private
      def coloize(str)
        defined?(Term::ANSIColor) ?  Term::ANSIColor.green(str) : str
      end
    end
  end
end
