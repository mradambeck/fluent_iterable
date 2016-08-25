require_relative '../lib/fluent_iterable'
require 'rspec'

RSpec.describe FluentIterable do
  context 'instance method behavior' do
    before do
      @fi = FluentIterable.new
      @fi.push(:something)
      @fi.push(:another_thing)
    end

    it 'enforces a homogenous storage' do
      expect { @fi.push('i am a string') }.to raise_error(ArgumentError)
    end

    it 'knows how many things it has stored' do
      expect(@fi.size).to eq(2)
    end

    it 'it can store many things' do
      expect(@fi.elements).to include(:something, :another_thing)
    end

    it 'can filter elements according to a predicate' do
      results = @fi.filter { |sym| :something == sym }
      expect(results.size).to eq(1)
      expect(results.elements).to include(:something)
    end

    it 'can transform elements according to a function' do
      results = @fi.transform { |sym| sym.to_s }
      expect(results.size).to eq(2)
      expect(results.elements).to include('something', 'another_thing')
    end
  end

  it 'can turn a list of ints into a map of symbols to classes over a certain value' do
    @fi = FluentIterable.new
          .push(:golden_state)
          .push(:blackthorn)
          .push(:ace)
          .filter { |sym| sym.size > 4 }
          .transform { |sym| Ciders::TYPES[sym].new.profile }
    expect(@fi.size).to eq(2)
    expect(@fi.elements).to eq(['dry', 'tart'])
  end
end
