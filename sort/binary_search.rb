class Array
  def binary_search(val, left = 0, right = nil)
    right = self.size - 1 unless right
    mid = (left + right) / 2
 
    return nil if left > right
 
    if val == self[mid]
      return mid
    elsif val > self[mid]
      binary_search(val, mid + 1, right)
    else
      binary_search(val, left, mid - 1)
    end
  end
end

a = [1, 3, 6, 8, 12, 14, 15, 20, 142].sort
 
puts [12, 1, 20, 142, 5].map { |i| 
  a.binary_search(i) 
}.join(', ')

# => 4, 0, 7, 8, nil
