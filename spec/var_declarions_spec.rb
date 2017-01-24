require 'spec_helper'
require 'pp'

describe Rubex do
  context "Rubex Ruby method with variable initialization and declaration" do
    before do
      @path = 'spec/fixtures/var_declarations/var_declarations.rubex'
    end

    context ".ast" do
      it "generates a valid AST" do
        a = Rubex.ast @path
      end
    end

    context ".compile" do
      it "compiles to valid C code" do
        t,c,e = Rubex.compile @path
      end
    end
  end
end
