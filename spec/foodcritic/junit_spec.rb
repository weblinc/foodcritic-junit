require "spec_helper"
module Foodcritic
  module Junit
    describe Foodcritic::Junit do
      let(:success_msg) { /Wrote test\/reports\/foodcritic-report.xml/ }
      let(:violations_input) { seed_dir.join('foodcritic-input-violations.txt').read }
      let(:violations_outputter) { Outputter.new(violations_input) }

      it "has a version number" do
        expect(Foodcritic::Junit::VERSION).not_to be nil
      end

      it 'builds a report for foodcritic violations' do
        expect { violations_outputter.run }.to output(success_msg).to_stderr_from_any_process
      end
    end
  end
end
