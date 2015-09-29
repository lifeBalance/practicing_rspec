describe 'Expectation matchers' do
  describe 'equivalence matchers' do

    it 'will match object equivalence(loose) with #eq' do
      a = '2 cats'
      b = '2 cats'
      expect(a).to eq(b)    # `a` and `b` have the same value.
      expect(b).to be == a  # synonym for #eq

      c = 17
      d = 17.0
      expect(c).to eq(d) # Same value, different types; it perfoms type conversion.
    end

    it 'will match object equivalence(stricter) with #eql' do
      a = '2 cats'
      b = '2 cats'
      expect(a).to eql(b) # 'eql' does not perfom type conversion.

      c = 17
      d = 17.0
      expect(c).not_to eql(d) # Same value, different types.
    end

    it 'will match object identity(same object id) with #equal' do
      a = '2 cats'
      b = '2 cats'
      expect(a).not_to equal(b) # `a` and `b` have different object ids.

      c = b
      expect(b).to be(c) # 2 references to the same object.
    end

  end

  describe 'truthiness matchers' do

    it 'will match true/false' do
      expect(1 < 2).to be(true)
      expect(1 > 2).to be(false)

      expect('foo').not_to be(true)
      expect(nil).not_to be(false)   # nil is "falsey", but not `false`.
      expect(0).not_to be(false)     # 0 is not `false`, not even "falsey".
    end

    it 'will match truthy/falsey' do
      expect(1 < 2).to be_truthy
      expect(1 > 2).to be_falsey

      expect('foo').to be_truthy  # Any object (except `nil`) is "truthy".
      expect(nil).to be_falsey    # nil is "falsey".
      expect(0).not_to be_falsey  # In Ruby, 0 is not "falsey".
    end

    it 'will match nil' do
      expect(nil).to be_nil
      expect(nil).to be nil

      expect(false).not_to be_nil   # `nil` is "falsey", but not `false`.
      expect(0).not_to be_nil       # 0 is not nil, nor falsey.
    end

  end

  describe 'numeric comparison matchers' do
    it 'will match less than/greater than' do
      expect(10).to be > 9
      expect(10).to be >= 10
      expect(10).to be <= 10
      expect(9).to be < 10
    end

    it 'will match numeric ranges' do
      expect(10).to be_between(5, 10).inclusive
      expect(10).not_to be_between(5, 10).exclusive
      expect(10).to be_within(1).of(11)
      expect(5..10).to cover(9)
    end
   end

  describe 'collection matchers' do
    it 'will match arrays' do
      array = [1, 2, 3]

      expect(array).to include(3)
      expect(array).to include(1, 3)

      expect(array).to start_with(1)
      expect(array).to end_with(3)

      expect(array).to match_array([3, 2, 1])
      expect(array).not_to match_array([1, 2])

      expect(array).to contain_exactly(1, 3, 2)
      expect(array).not_to contain_exactly(1, 2)
    end

    it 'will match strings' do
      string = 'some string'

      expect(string).to include('ring')
      expect(string).to include('so', 'ring')

      expect(string).to start_with('so')
      expect(string).to end_with('ring')
    end

    it 'will match hashes' do
      hash = { :a => 1, :b => 2, :c => 3 }

      expect(hash).to include(:a)
      expect(hash).to include(:a => 1)
      expect(hash).to include(:a => 1, :c => 3)
      expect(hash).to include({ :a => 1, :c => 3 })
      expect(hash).not_to include({ 'a' => 1, 'c' => 3 })
    end
  end

end
