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

end
