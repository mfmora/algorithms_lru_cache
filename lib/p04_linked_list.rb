require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    @next = nil
    @prev = nil
    self
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    any? { |link| link.key == key }
  end

  def append(key, val)
    link = Link.new(key, val)
    @tail.prev.next = link
    link.prev = @tail.prev
    link.next = @tail
    @tail.prev = link
    link
  end

  def update(key, val)
    each do |link|
      if link.key == key
        link.val = val
        return link
      end
    end
    nil
  end

  def remove(key)
    each { |link| return link.remove.val if link.key == key }

    nil
  end

  def each(&prc)
    link = @head.next
    until link == @tail
      prc.call(link)
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
