require './state'

class Application
  attr_accessor :current_state
  attr_reader :states

  def initialize(options = {})
    @initial_state = State.new({}, true)
    @current_state = @initial_state
    @states       = [@initial_state]
  end

  def begin_transaction
    @current_state = State.new(current_state)
    states.push(@current_state)
    return "OK"
  end

  def delete_value(key)
    if @current_state.delete(key)
      "OK"
    else
      "key not set"
    end
  end

  def get_value(key)
    if value = @current_state.get(key)
      value
    else
      "nil"
    end
  end

  def set_value(key, value)
    if @current_state.set(key, value)
      "OK"
    end
  end

  def count_keys(value)
    @current_state.count(value)
  end

  def commit_transaction
    if @current_state.persisted
      "No transaction to commit"
    else
      @current_state.persist
      "OK"
    end
  end

  def rollback_transaction
    if can_rollback?
      states.delete_at(-1)
      @current_state = states.last
      "OK"
    else
      "No transaction to rollback"
    end
  end

  private

  def can_rollback?
    !states.at(-1).persisted?
  end
end