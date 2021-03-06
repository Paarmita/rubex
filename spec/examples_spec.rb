require 'spec_helper'

describe Rubex do
  test_case = 'examples'

  examples = ['rcsv', 'array_to_hash'].each do |example|
    context "Case: #{test_case}/#{example}" do
      before do
        @path = path_str test_case, example
      end

      context ".ast" do
        it "generates the AST" do
          t = Rubex::Compiler.ast(@path + '.rubex')
        end
      end

      context ".compile", now: true do
        it "compiles to valid C file" do
          t,c,e = Rubex::Compiler.compile(@path + '.rubex', test: true)
        end
      end

      context "Black Box testing", now: true do
        it "compiles and checks for valid output" do
          def rcsv
            result = [
              ["Name", "age", "sex"],
              ["Sameer", "24", "M"],
              ["Ameya", "23", "M"],
              ["Neeraja", "23", "F"],
              ["Shounak", "24", "M"]
            ]

            a = Rcsv.parse(File.read('spec/fixtures/examples/rcsv.csv'), {})
            expect(a).to eq(result)
          end

          def array_to_hash
            a = ["a", "b", "c"]
            expect(a.each_with_index.to_h).to eq(Array2Hash.convert(a))
          end

          setup_and_teardown_compiled_files(test_case, example) do |dir|
            require_relative "#{dir}/#{example}.#{os_extension}"
            self.send(example.to_sym)
          end
        end
      end
    end
  end
end
