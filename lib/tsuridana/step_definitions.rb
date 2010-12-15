# coding: utf-8
require 'ripper'
require 'yaml'

module Tsuridana
  class StepDefinitions < Ripper::Filter
    StepDefinition = Struct.new(:keyword, :re_src, :lino)
    attr_reader :step_definitions, :src

    def self.cucumber_keywords
      return @keywords if @keywords

      # XXX refactor
      source = Dir[File.expand_path("../vendor/gherkin-*-i18n.yml", File.dirname(__FILE__))].last
      keywords = YAML.load_file(source).inject([]) { |keywords, (lang, gherkin_keywords)|
        keywords << %w[given when then].map{|n| gherkin_keywords[n].split('|') }
      }.flatten.each{|k| k.gsub!(/\<\z/, '') }.uniq
      keywords.delete('*')
      @keywords = keywords
    end

    def initialize(path, additional_keywords = [], filename = '-', lineno = 1)
      super(File.read(path), filename, lineno)
      @src = path
      @keywords = (self.class.cucumber_keywords.dup + additional_keywords).uniq
      @step_definitions = []
    end

    def on_default(event, tok, f)
      f << tok
    end

    def handle_if_keyword(tok, f)
      if column.zero? && @keywords.include?(tok)
        step_definitions << StepDefinition.new(tok)
        @stat = :step
      end
      on_default(:const, tok, f)
    end

    def on_const(tok, f)
      handle_if_keyword(tok, f)
    end

    def on_ident(tok, f)
      handle_if_keyword(tok, f)
    end

    def on_regexp_beg(tok,f)
      @stat = :step_re if @stat == :step
      on_default(:on_regexp_bgn, tok, f)
    end

    def on_tstring_content(tok, f)
      if @stat == :step_re
        current_step.re_src = tok
        current_step.lino = lineno
        @stat == :step_re_stored
      end
      on_default(:tstring_content, tok, f)
    end

    def on_regexp_end(tok, f)
      @stat = :step_re_end
      on_default(:on_regexp_end, tok, f)
    end

    private
    def current_step
      step_definitions.last
    end
  end
end

