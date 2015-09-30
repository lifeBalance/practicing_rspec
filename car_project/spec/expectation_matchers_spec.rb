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

  describe 'other useful matchers' do
    it 'will match strings with a regex' do
      string = 'The order has been received'
      expect(string).to match(/order(.+)received/)

      expect('123').to match(/\d{3}/)
      expect(123).not_to match(/\d{3}/)

      email = 'someone@somewhere.com'
      expect(email).to match(/\A\w+@\w+\.\w{3}\Z/)
    end

    it 'will match object types' do
      expect('test').to be_instance_of(String)
      expect('test').to be_an_instance_of(String) # Just an alias

      expect('test').to be_kind_of(String)
      expect('test').to be_a_kind_of(String)  # Just an alias
      expect('test').to be_a(String)          # Just an alias
      expect([1, 2, 3]).to be_an(Array)       # Just an alias
    end

    it 'will match objects with #respond_to' do
      string = 'test'

      expect(string).to respond_to(:length)
      expect(string).not_to respond_to(:sort)
    end

    it 'will match instances with #have_attributes' do
      class Car
        attr_accessor :make, :year, :color
      end

      car = Car.new
      car.make = 'Dodge'; car.year = 2010; car.color = 'green'

      expect(car).to have_attributes(:color => 'green')
      expect(car).to have_attributes(:make => 'Dodge', :year => 2010)
    end

    it 'will match anything with #satisfy' do
      expect(10).to satisfy do |value|
        (value >= 5) && (value <= 10) && (value % 2 == 0)
      end
    end

  end

  describe 'dynamic predicate matchers' do
    it 'will match be_* to predicate methods ending in ?' do
      expect([]).to be_empty    # [].empty?
      expect(1).to be_integer   # 1.integer?
      expect(0).to be_zero      # 0.zero?
      expect(1).to be_nonzero  # 1.nonzero?
      expect(1).to be_odd       # 1.odd?
      expect(2).to be_even      # 2.even?
      expect(nil).to be_nil     # nil.nil?

      class Product
        def visible?; true; end;
      end
      product = Product.new

      expect(product).to be_visible
      expect(product.visible?).to be true # Equivalent to line above
    end

    it 'will match have_* to predicate methods like has_*?' do
      hash = { :a => 1, :b => 2 }
      # Built-in methods
      expect(hash).to have_key(:a)
      expect(hash).to have_value(2)

      # Custom methods
      class Customer
        def has_pending_order?; true; end;
      end
      customer = Customer.new

      expect(customer).to have_pending_order
      expect(customer.has_pending_order?).to be true   # Equivalent to above
    end

  end

  describe 'observation matchers' do
    it 'will match when events change object attributes' do
      array = []
      expect { array << 1 }.to change(array, :empty?).from(true).to(false)

      class WebsiteHits
        attr_accessor :count
        def initialize; @count = 0; end;
        def increment; @count += 1; end;
      end
      hits = WebsiteHits.new
      expect { hits.increment }.to change(hits, :count).from(0).to(1)
    end

    it 'will match when events change any values' do
      x = 10
      expect { x += 1 }.to change {x}.from(10).to(11)
      expect { x += 1 }.to change {x}.by(1)
      expect { x += 1 }.to change {x}.by_at_least(1)
      expect { x += 1 }.to change {x}.by_at_most(1)

      z = 11
      expect { z += 1 }.to change { z % 3}.from(2).to(0)
    end

    it 'will match when errors are raised' do
      expect { raise StandardError }.to raise_error(StandardError)
      expect { raise StandardError }.to raise_exception(StandardError)

      expect { 1 / 0 }.to raise_error(ZeroDivisionError)
      expect { 1 / 0 }.to raise_error.with_message('divided by 0')
      expect { 1 / 0 }.to raise_error.with_message(/divided/)
      expect { 1 / 1 }.not_to raise_error
    end

    it 'will match when output is generated' do
      expect { print 'hello' }.to output.to_stdout
      expect { print 'hello' }.to output('hello').to_stdout
      expect { print 'hello' }.to output(/ll/).to_stdout

      expect { warn('problem') }.to output(/problem/).to_stderr
    end
  end

  describe 'compound expectations' do
    it 'will match using: and, or, &, |' do
      expect([1, 2, 3, 4]).to start_with(1).and end_with(4)

      expect([1, 2, 3, 4]).to start_with(1) & include(2)

      expect(10 * 10).to be_odd.or be > 50

      array = ['hello', 'goodbye'].shuffle
      expect(array.first).to eq('hello') | eq('goodbye')
    end
  end

end
