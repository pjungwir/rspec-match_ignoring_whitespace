describe 'match_ignoring_whitespace' do

  let(:expected) { "πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα." }

  context "matches" do
    specify 'an identical string' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
    end
    specify 'a string with newlines' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,\nἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,\n\nἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, \nἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, \n ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
    end
    specify 'a string with leading whitespace' do
      expect(" πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("  πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("\tπόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("\nπόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("\n\nπόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("\t πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect(" \tπόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
    end
    specify 'a string with trailing whitespace' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα. ").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.  ").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.\t").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.\n").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.\n\n").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα.\t ").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα. \t").to match_ignoring_whitespace expected
    end
    specify 'a string with extra whitespace' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,  ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,   ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ, \t ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
    end
    specify 'a string with a non-breaking space' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,\u{00a0}ἀλλ΄ ἐχῖνος ἓν μέγα.").to match_ignoring_whitespace expected
    end
  end

  context "doesn't match" do
    specify 'nil' do
      expect(nil).not_to match_ignoring_whitespace expected
    end
    specify 'an empty string' do
      expect('').not_to match_ignoring_whitespace expected
    end
    specify 'a single space' do
      expect(' ').not_to match_ignoring_whitespace expected
    end
    specify 'a different string' do
      expect('χρημάτων ἄελπτον οὐδέν ἐστιν οὐδ᾽ ἀπώμιον οὐδὲ θαυμάσιον').not_to match_ignoring_whitespace expected
    end
    specify 'a string missing a space' do
      expect("πόλλ΄ οἶδ΄ ἀλώπηξ,ἀλλ΄ ἐχῖνος ἓν μέγα.").not_to match_ignoring_whitespace expected
    end
    specify 'expecting nil' do
      expect('anything').not_to match_ignoring_whitespace(nil)
    end
  end
end
