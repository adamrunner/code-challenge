class State
  attr_reader :data
  attr_reader :persisted
  alias_method :persisted?, :persisted

  def initialize(starting_state = nil, persisted = false)
    @persisted = persisted

    if starting_state
      @data = starting_state.dup
    else
      @data = {}
    end
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

  def dup
    data.dup
  end

end