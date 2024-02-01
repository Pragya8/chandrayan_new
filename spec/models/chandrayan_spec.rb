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
      chandrayan = FactoryBot.build(:chandrayan)
      chandrayan.move_forward
      expect(chandrayan.current_position[:y]).to eq(1)
    end
  end

  describe '#move_backward' do
    it 'moves the chandrayan one step backward in the current direction' do
      chandrayan = FactoryBot.build(:chandrayan)
      chandrayan.move_backward
      expect(chandrayan.current_position[:y]).to eq(-1)
    end

    it 'does not allow the chandrayan to move beyond galactic boundaries' do
      chandrayan = FactoryBot.build(:chandrayan, x: 0, y: 0, z: 0, direction: 'W')
      chandrayan.move_backward
      expect(chandrayan.current_position[:y]).to eq(-1)
    end
  end

  describe '#turn_right' do
    it 'turns the chandrayan 90 degrees to the right' do
      chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: 'N')
      chandrayan.rotate_right
      expect(chandrayan.current_direction).to eq('S')
    end
  end

  describe '#turn_left' do
    it 'turns the chandrayan 90 degrees to the left' do
      chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: 'N')
      chandrayan.rotate_left
      expect(chandrayan.current_direction).to eq('Down')
    end
  end

  describe '#turn_up' do
    it 'turns the chandrayan upwards' do
      chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: 'N')
      chandrayan.rotate_up
      expect(chandrayan.current_direction).to eq('Up')
    end
  end

  describe '#turn_down' do
    it 'turns the chandrayan downwards' do
      chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: 'Up')
      chandrayan.rotate_down
      expect(chandrayan.current_direction).to eq('Down')
    end
  end
  describe '#execute_commands' do
    it 'executes a series of commands accurately and efficiently' do
      chandrayan = FactoryBot.build(:chandrayan, x: nil, y: nil, z: nil, direction: 'N')
      chandrayan.execute_commands(['f', 'r', 'u', 'b', 'l'])
      expect(chandrayan.current_position).to eq({:x=>0, :y=>1, :z=>-1})
      expect(chandrayan.current_direction).to eq('W')
    end
  end
end