require './state'

class Application
  attr_accessor :current_state
  attr_reader :states

  def initialize(options = {})
    @initial_state = State.new({"foo": "bar"}, true)
    @current_state = @initial_state
    @states       = [@initial_state]
  end

  def new_transaction
    @current_state = State.new(current_state)
    states.push(@current_state)
  end

  def delete_value(key)
    @current_state.delete(key)
  end

  def get_value(key)
    @current_state.get(key)
  end

  def set_value(key, value)
    @current_state.set(key, value)
  end

  def count_keys(value)
    @current_state.count(value)
  end

  def commit_transaction
    return false if @current_state.persisted

    @current_state.persist
  end

  def rollback_transaction
    # bail out early if we've never put a new state on the stack
    return false if states.at(-1).persisted?
    states.delete_at(-1)
    @current_state = states.last
  end
end