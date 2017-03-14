require 'foodcritic/junit/version'
require 'fileutils'
require 'pathname'
require 'time'

module Foodcritic
  module Junit
    class Outputter

      attr_reader :violations, :cookbook_name, :current_violation, :current_violation_lines,
                  :output_dir, :output_file, :current_file_name, :input

      def initialize(input)
        @input = input
        @violations = []
        @cookbook_name = ENV['COOKBOOK_NAME'] || File.basename(Dir.pwd)
        @output_dir = Pathname.new(ENV['FOODCRITIC_JUNIT_OUTPUT_DIR'] || 'test/reports')
        @output_file = ENV['FOODCRITIC_JUNIT_OUTPUT_FILE'] || 'foodcritic-report.xml'
      end

      def run
        parse_violations
        write_output
      end

      def parse_violations
        input.each_line do |line|
          line.chomp!

          @current_file_name = line if File.exist?(line)

          violation = line.match(/(?<rule>[A-Z]+\d+?):\s(?<message>.+?)$/)

          if violation
            # We got a new violation, store the current one + it's lines
            if current_violation
              violations.push({
                rule: current_violation[:rule],
                message: current_violation[:message],
                file_name: current_file_name,
                lines: current_violation_lines.join("\n")
              })
            end

            @current_violation = violation
            @current_violation_lines = []
          else
            current_violation_lines << line.lstrip if current_violation_lines
          end
        end
      end

      def output_file_path
        output_dir.join(output_file)
      end

      def write_output
        output_dir.mkpath
        File.open(output_file_path, 'w') { |f| f.puts(xml) }
        STDERR.puts("Wrote #{output_file_path}")
      end

      def xml
        <<-EOS
<?xml version="1.0" encoding="UTF-8"?>
<testsuites>
  <testsuite name=#{cookbook_name.encode(xml: :attr)} timestamp=#{Time.now.utc.iso8601.to_s.encode(xml: :attr)}>
    #{violations_as_xml}
  </testsuite>
</testsuites>
        EOS
      end

      def violations_as_xml
        if violations.any?
          violations.map { |v| xml_for_violation(v) }.join("\n")
        else
          '<testcase classname="foodcritic-junit" name="No Errors"/>'
        end
      end

      def xml_for_violation(violation)
        name = "#{violation[:rule]}: #{violation[:message]}".encode(xml: :attr)
        file_name = violation[:file_name].encode(xml: :attr)
        location = "Located in #{violation[:file_name]}".encode(xml: :attr)
        <<-EOS
      <testcase name=#{name} classname=#{file_name} assertions="0" time="0">
        <error type=#{name} message=#{location}>
          #{violation[:lines].encode(xml: :text)}
        </error>
      </testcase>
        EOS
      end
    end
  end
end
