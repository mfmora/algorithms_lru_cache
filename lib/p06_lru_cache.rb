require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map.include?(key) ? update_link!(@map[key]) : calc!(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @map[key] = @store.append(key, @prc.call(key))

    eject! if count > @max
    @map[key].val
  end

  def update_link!(link)
    link.remove
    @store.append(link.key, link.val).val
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    ejected_link = @store.first.remove
    @map.delete(ejected_link.key)
  end
end
