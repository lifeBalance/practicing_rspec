describe 'Doubles' do

  it 'allow stubbing methods' do
    dbl = double('Chant')
    allow(dbl).to receive(:hey!)
    expect(dbl).to respond_to(:hey!)
  end

  it 'allow stubbing a response with a block' do
    dbl = double('Chant')
    # Controlling the response using a block.
    allow(dbl).to receive(:hey!) { 'Hoo!' }
    expect(dbl.hey!).to eq('Hoo!')
  end

  it 'allow stubbing responses with #and_return' do
    dbl = double('Chant')
    # Controlling the response using the #and_return method
    allow(dbl).to receive(:hey!).and_return('Hoo!')
    expect(dbl.hey!).to eq('Hoo!')
  end

  it 'allow stubbing multiple methods with hash syntax' do
    dbl = double('Person')
    allow(dbl).to receive_messages( :full_name => 'Mary Smith',
                                    :initials => 'MS')
    expect(dbl.full_name).to eq('Mary Smith')
    expect(dbl.initials).to eq('MS')
  end

  it 'allow multiple responses with #and_return' do
    die = double('Die')
    allow(die).to receive(:roll).and_return(1, 5, 2, 6)
    expect(die.roll).to eq(1)
    expect(die.roll).to eq(5)
    expect(die.roll).to eq(2)
    expect(die.roll).to eq(6)
    expect(die.roll).to eq(6) # continues returning last value
  end

  context 'with partial test doubles' do

    it 'allows stubbing instance methods on Ruby classes' do
      time = Time.new(2010, 1, 1, 12, 0, 0)
      allow(time).to receive(:year).and_return(1975)

      expect(time.to_s).to eq('2010-01-01 12:00:00 +0300')
      expect(time.year).to eq(1975)
    end

    it 'allows stubbing instance methods on custom classes' do
      class Superhero
        attr_accessor :name
      end

      hero = Superhero.new
      hero.name = 'Superman'
      expect(hero.name).to eq('Superman')

      allow(hero).to receive(:name).and_return('Clark Kent')
      expect(hero.name).to eq('Clark Kent')
    end

    it 'allows stubbing class methods on Ruby classes' do
      fixed = Time.new(2010, 1, 1, 12, 0, 0)
      allow(Time).to receive(:now).and_return(fixed)

      expect(Time.now).to eq(fixed)
      expect(Time.now.to_s).to eq('2010-01-01 12:00:00 +0300')
      expect(Time.now.year).to eq(2010)
    end

    it 'allows stubbing database calls a mock object' do
      class Customer
        attr_accessor :name
        def self.find
          # Looks up in the database and returns one object
        end
      end

      dbl = double('Mock customer')
      allow(dbl).to receive(:name).and_return('Bob')

      allow(Customer).to receive(:find).and_return(dbl)

      customer = Customer.find
      expect(customer.name).to eq('Bob')
    end

    it 'allows stubbing database calls with many mock objects' do
      class Customer
        attr_accessor :name
        def self.all
          # Looks up in the database and returns one object
        end
      end

      c1 = double('First customer', :name => 'Bob')
      c2 = double('Second customer', :name => 'Mary')

      allow(Customer).to receive(:all).and_return([c1, c2])

      customers = Customer.all
      expect(customers[1].name).to eq('Mary')
    end

  end

end
