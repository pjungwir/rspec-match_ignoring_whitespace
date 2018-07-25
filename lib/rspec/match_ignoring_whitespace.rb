require 'rspec'
require 'levenstein_with_path'
require 'word_wrap'

def collapse_spaces(str)
  str.gsub(/[[:space:]]+/, ' ').strip
end

RSpec::Matchers.define :match_ignoring_whitespace do |expected|
  expected = expected.to_s

  match do |actual|
    actual = actual.to_s
    collapse_spaces(actual) == collapse_spaces(expected)
  end

  failure_message do |actual|
    actual = actual.to_s
    actual_normalized   = collapse_spaces(actual)
    expected_normalized = collapse_spaces(expected)

    diff = LevensteinWithPath::Path.new(
      expected_normalized.split(' '),
      actual_normalized.split(' ')
    )
    runs = []
    last_edit = nil
    diff.edits.each do |edit|
      last_edit = runs.last
      if last_edit.class == edit.class
        runs.pop
        case edit
        when LevensteinWithPath::Keep
          runs << LevensteinWithPath::Keep.new(last_edit.token + [edit.token])
        when LevensteinWithPath::Swap
          runs << LevensteinWithPath::Swap.new(last_edit.token1 + [edit.token1], last_edit.token2 + [edit.token2])
        when LevensteinWithPath::Insert
          runs << LevensteinWithPath::Insert.new(last_edit.token + [edit.token])
        when LevensteinWithPath::Delete
          runs << LevensteinWithPath::Delete.new(last_edit.token + [edit.token])
        else
          raise "Unknown class: #{edit}"
        end
      else
        case edit
        when LevensteinWithPath::Keep
          runs << LevensteinWithPath::Keep.new([edit.token])
        when LevensteinWithPath::Swap
          runs << LevensteinWithPath::Swap.new([edit.token1], [edit.token2])
        when LevensteinWithPath::Insert
          runs << LevensteinWithPath::Insert.new([edit.token])
        when LevensteinWithPath::Delete
          runs << LevensteinWithPath::Delete.new([edit.token])
        else
          raise "Unknown class: #{edit}"
        end
      end
    end

    runs.flat_map do |run|
      case run
      when LevensteinWithPath::Keep
        WordWrap.ww(run.token.join(' '), 78).split("\n").map do |line|
          "  #{line}"
        end
      when LevensteinWithPath::Swap
        WordWrap.ww(run.token1.join(' '), 78).split("\n").map do |line|
          "- #{line}"
        end +
        WordWrap.ww(run.token2.join(' '), 78).split("\n").map do |line|
          "+ #{line}"
        end
      when LevensteinWithPath::Insert
        WordWrap.ww(run.token.join(' '), 78).split("\n").map do |line|
          "+ #{line}"
        end
      when LevensteinWithPath::Delete
        WordWrap.ww(run.token.join(' '), 78).split("\n").map do |line|
          "- #{line}"
        end
      else
        raise "Unknown class: #{run}"
      end
    end.join("\n")
  end
end
