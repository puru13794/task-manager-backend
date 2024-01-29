
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) } # Assuming you have a User factory
  let(:valid_attributes) { { title: 'Test Task', description: 'Test Description', status: 'todo', user: user } }
  let(:invalid_attributes) { { title: '', description: '', status: 'todo', user: user } }

  describe 'validations' do
    it { should validate_presence_of(:title).with_message("Title can't be blank") }
    it { should validate_presence_of(:description).with_message("Description can't be blank") }
    it { should define_enum_for(:status).with_values([:todo, :in_progress, :done]) }
    it { should validate_inclusion_of(:status).in_array([:todo, :in_progress, :done]).with_message("Invalid status value") }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'creation' do
    it 'is valid with valid attributes' do
      task = Task.new(valid_attributes)
      expect(task).to be_valid
    end

    it 'is not valid with invalid attributes' do
      task = Task.new(invalid_attributes)
      expect(task).not_to be_valid
    end
  end
end
