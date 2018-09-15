class State
  attr_reader :data
  attr_reader :persisted
  alias_method :persisted?, :persisted

  def initialize(starting_state = {}, persisted = false)
    @persisted = persisted
    @data      = starting_state.dup
  end

  def persist
    @persisted = true
  end

  def set(key, value)
    data[key] = value
  end

  def get(key)
    data[key]
  end

  def delete(key)
    data.delete(key)
  end

  def count(value)
    data.select {|k,v| v == value}.count
  end

  # implement a dup call on our state object
  # so we can pass either a hash or a state object
  # when we instantiate a new state object

  def dup
    data.dup
  end

end