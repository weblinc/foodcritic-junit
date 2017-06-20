require "spec_helper"
module Foodcritic
  module Junit
    describe Foodcritic::Junit do
      let(:success_msg) { /Wrote test\/reports\/foodcritic-report.xml/ }
      it "has a version number" do
        expect(Foodcritic::Junit::VERSION).not_to be nil
      end

      context 'with existing files for all violations' do
        let(:violations_input) { seed_dir.join('foodcritic-input-violations.txt').read }
        let(:violations_outputter) { Outputter.new(violations_input) }

        it 'builds a report for foodcritic violations' do
          expect { violations_outputter.run }.to output(success_msg).to_stderr_from_any_process
        end
      end

      context 'with missing files for first violation' do
        before do
          # Stub out File.exist? for README.md and LICENSE so we do not get the
          # ones from the foodcritic-junit gem
          allow(File).to receive(:exist?).and_call_original
          %w(README.md LICENSE).each do |file|
            allow(File).to receive(:exist?).with(file).and_return(false)
          end
        end

        let(:violations_input) { seed_dir.join('foodcritic-input-missing-violations.txt').read }
        let(:violations_outputter) { Outputter.new(violations_input) }

        it 'builds a report for foodcritic violations' do
          expect { violations_outputter.run }.to output(success_msg).to_stderr_from_any_process
        end
      end
    end
  end
end
