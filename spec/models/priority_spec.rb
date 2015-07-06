require 'rails_helper'

RSpec.describe Priority, type: :model do
  context "indexes" do
    it { should have_db_index(:name) }
  end

  context "columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string).with_options(limit: 25, null: false) }
    it { should have_db_column(:value).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context "attributes" do
    it "has name" do
      expect(Priority.new(name: 'High')).to have_attributes(name: 'High')
    end

    it "has value" do
      expect(Priority.new(value: 10)).to have_attributes(value: 10)
    end
  end

  context "validation" do
    before do
      @priority = Priority.new(name: 'High', value: 10)
    end

    it "requires name" do
      expect(@priority).to validate_presence_of(:name)
    end

    it "requires name to be within 3 to 8" do
      expect(@priority).to validate_length_of(:name).is_at_least(3).is_at_most(8)
    end

    it "requires value" do
      expect(@priority).to validate_presence_of(:value)
    end

    it "requires value be an integer" do
      expect(@priority).to validate_numericality_of(:value).only_integer
    end
  end

  context "scopes" do
    it "returns important priorities first" do
      Priority.create(name: 'Medium', value: 5)
      Priority.create(name: 'Low', value: 1)
      Priority.create(name: 'High', value: 10)
      expect(Priority.important.first.name).to eq('High')
    end
  end
end
