# Copyright (c) 2011 the authors listed at the following URL, and/or
# the authors of referenced articles or incorporated external code:
# http://en.literateprograms.org/Merge_sort_(Ruby)?action=history&offset=20090108065112
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
# Retrieved from: http://en.literateprograms.org/Merge_sort_(Ruby)?oldid=15832

class Array
  def merge_sort(&predicate)
    if size <= 1
      self.dup
    else
      halves = split.map{ |half|
        half.merge_sort(&predicate)
      }
      merge(*halves, &predicate)
    end
  end


  protected
  def split_rec(ls1, ls2, result)
    if ls1.size <= 1
      [result, ls2]
    else
      split_rec(ls1[2..-1], ls2[1..-1], result + [ls2.first])
    end
  end

  def split
    split_rec(self, self, [])
  end

  def merge(first, second, &predicate)
    if first.empty?
      second.dup
    elsif second.empty?
      first.dup
    elsif predicate.call(first.first, second.first)
      [first.first] + merge(first[1..-1], second, &predicate)
    else
      [second.first] + merge(first, second[1..-1], &predicate)
    end
  end

end

p [1, 5, 6, 4, 3].merge_sort{ |a,b| a <= b }

