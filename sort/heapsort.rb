module HeapSort
  def self.sort(keys)
    sort!(keys.clone)
  end
 
  def self.sort!(keys)
    build_max_heap(keys)
    (keys.size-1).downto(1) do |i|
      keys[0], keys[i] = keys[i], keys[0]
      max_heapify(keys, i, 0)
    end
    keys
  end
 
  private
 
  def self.build_max_heap(keys)
    (keys.size/2-1).downto(0) do |i|
      max_heapify(keys, keys.size, i)
    end
    keys
  end
 
  def self.max_heapify(keys, size, i)
    l = 2*i+1
    r = 2*i+2
    if l < size and keys[l] > keys[i]
      largest = l 
    else 
      largest = i
    end
    if r < size and keys[r] > keys[largest]
      largest = r 
    end
    if (largest != i)
      keys[i], keys[largest] = keys[largest], keys[i]
      max_heapify(keys, size, largest)
    end
  end
end
