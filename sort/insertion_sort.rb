# Copyright (c) 2011 the authors listed at the following URL, and/or
# the authors of referenced articles or incorporated external code:
# http://en.literateprograms.org/Insertion_sort_(Ruby)?action=history&offset=20060602233259
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
# Retrieved from: http://en.literateprograms.org/Insertion_sort_(Ruby)?oldid=5737

# Sort an array of integers
def insertion_sort(a)
  a.each_with_index do |el,i|
    # Insert el into the sorted sublist
    j = i - 1
    while j >= 0
      break if a[j] <= el
      a[j + 1] = a[j]
      j -= 1
    end
    a[j + 1] = el

  end
end

def checkThatArrayIsSorted(array)
  1.upto(array.size - 1) do |i|
    if array[i-1] > array[i]
      puts "The array is not in sorted order at position #{i-1}"
    end
  end
end

a = [ 5, 1, 9, 3, 2 ]
insertion_sort(a)
puts a.join("\n")

checkThatArrayIsSorted(a)



