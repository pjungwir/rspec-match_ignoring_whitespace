require 'rspec'

RSpec::Matchers.define :match_ignoring_whitespace do |expected|
  expected = expected.to_s

  match do |actual|
    actual = actual.to_s
    actual.gsub(/[\n[[:blank:]]]+/, ' ').strip == expected.gsub(/[\n[[:blank:]]]+/, ' ').strip
  end

  failure_message do |actual|
    actual = actual.to_s
    actual_normalized   = actual.gsub(/[\n[[:blank:]]]+/, ' ').strip
    expected_normalized = expected.gsub(/[\n[[:blank:]]]+/, ' ').strip

    message = <<-EOF.strip
expected: #{expected_normalized.inspect}
     got: #{actual_normalized.inspect}
    EOF

    diff = RSpec::Expectations.differ.diff(actual_normalized, expected_normalized)

    unless diff.strip.empty?
      diff_label = RSpec::Matchers::ExpectedsForMultipleDiffs::DEFAULT_DIFF_LABEL
      message << "\n\n" << diff_label << diff
    end

    message
  end
end
