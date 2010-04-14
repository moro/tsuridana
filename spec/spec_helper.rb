# coding: utf-8
$:.unshift File.expand_path("../lib", File.dirname(__FILE__))

def fixture(path)
  File.expand_path("fixtures/#{path}", File.dirname(__FILE__))
end

