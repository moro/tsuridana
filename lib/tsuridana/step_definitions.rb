# coding: utf-8
require 'ripper'

module Tsuridana
  class StepDefinitions < Ripper::Filter
    StepDefinition = Struct.new(:keyword, :re_src, :lino)
    attr_reader :step_definitions, :src

    CUCUMBER_KEYWORDS = [
      [:en, %w[Given When Then And]]
    ].freeze

    def initialize(path, additional_keywords = [], filename = '-', lineno = 1)
      super(File.read(path), filename, lineno)
      @src = path
      @keywords = CUCUMBER_KEYWORDS.assoc(:en).last + additional_keywords
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

