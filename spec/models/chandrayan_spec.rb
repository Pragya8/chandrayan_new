# spec/models/chandrayan_spec.rb
require 'rails_helper'

RSpec.describe Chandrayan, type: :model do

  it 'is valid with valid attributes' do
    chandrayan = FactoryBot.build(:chandrayan)
    expect(chandrayan).to be_valid
  end

  it 'is not valid without x, y, z, or direction' do
    chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: nil)
    expect(chandrayan).not_to be_valid
  end

  describe '#move_forward' do
    it 'moves the chandrayan one step forward in the current direction' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.move_forward
      expect(chandrayan.y).to eq(1)
    end
  end

  describe '#move_backward' do
    it 'moves the chandrayan one step backward in the current direction' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.move_backward
      expect(chandrayan.y).to eq(-1)
    end

    it 'does not allow the chandrayan to move beyond galactic boundaries' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'W')
      chandrayan.move_backward
      expect(chandrayan.x).to eq(1) # Should not move beyond the boundary
    end
  end
  describe '#turn_right' do
    it 'turns the chandrayan 90 degrees to the right' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.turn_right
      expect(chandrayan.direction).to eq('E')
    end
  end

  describe '#turn_left' do
    it 'turns the chandrayan 90 degrees to the left' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.turn_left
      expect(chandrayan.direction).to eq('W')
    end
  end

  describe '#turn_up' do
    it 'turns the chandrayan upwards' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.turn_up
      expect(chandrayan.direction).to eq('Up')
    end
  end

  describe '#turn_down' do
    it 'turns the chandrayan downwards' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'Up')
      chandrayan.turn_down
      expect(chandrayan.direction).to eq('Down')
    end
  end
  describe '#execute_commands' do
    it 'executes a series of commands accurately and efficiently' do
      chandrayan = Chandrayan.new(x: 0, y: 0, z: 0, direction: 'N')
      chandrayan.execute_commands(['f', 'r', 'u', 'b', 'l'])
      expect(chandrayan.position).to eq([0, 1, 0])
      expect(chandrayan.direction).to eq('W')
    end
  end
end
