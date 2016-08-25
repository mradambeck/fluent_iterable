class FluentIterable
  def initialize
    @storage = []
  end

  def push(item)
    if @storage.size > 1
      raise ArgumentError.new("some message") unless @storage[0].class == item.class
    end
    @storage << item
    self
  end

  def size
    @storage.size
  end

  def elements
    @storage.dup
  end

  def filter(&blk)
    new_storage = []
    @storage.each do |i|
      new_storage << i if blk.(i)
    end
    @storage = new_storage
    self
  end

  def transform(&blk)
    @storage.map!(&blk)
    self
  end
end

class Cider
  def profile
    "generic"
  end
end
class GoldenState < Cider
  def profile
    "dry"
  end
end
class Blackthorn < Cider
  def profile
    "tart"
  end
end
class Ace < Cider
  def profile
    "sweet"
  end
end

class Ciders
  TYPES = {
    golden_state: GoldenState,
    blackthorn: Blackthorn,
    ace: Ace,
  }.freeze
end
