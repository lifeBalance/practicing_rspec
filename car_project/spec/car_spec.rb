require 'car'

# describe "Car" do
# Using a class name allows us to use implicit subjects, meaning that
# we'll have available a barebones instance of `Car` under the name `subject`
describe Car do
  describe "attributes" do

    # before(:example) do
    #   @car = Car.new
    # end

    # `let` is better than `before` for
    # setting up instance variables
    # let(:car) { Car.new }

    # Or we can use `subject`
    # subject { Car.new } # we don't need a explicit subject anymore

    it 'allows reading and writing for :make' do
      subject.make = 'Test'
      expect(subject.make).to eq('Test')
    end

    it 'allows reading and writing for :year' do
      subject.year = 9999
      expect(subject.year).to eq(9999)
    end

    it 'allows reading and writing for :color' do
      subject.color = 'foo'
      expect(subject.color).to eq('foo')
    end

    it 'allows reading for :wheels' do
      expect(subject.wheels).to eq(4)
    end

    it 'allows writing for :doors' # Pending
  end

  describe ".colors" do
    let(:colors) { ['red', 'green', 'blue', 'black'] }
    it 'returns an array of color names' do
      expect(Car.colors).to(match_array(colors))
    end
  end

  describe "#full_name" do
    let(:honda) { Car.new(:make => 'Honda', :year => 2004, :color => 'blue') }
    let(:new_car) { Car.new }
    it 'returns a string in the expected format' do
      expect(honda.full_name).to eq('2004 Honda (blue)')
    end

    context 'when initialized with no arguments' do
      it 'returns a string using default values' do
        expect(new_car.full_name).to eq('2007 Volvo (unknown)')
      end
    end
  end
end
