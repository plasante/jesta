require 'pp'

class Hash

   def deep_merge!(second)
      # cf. http://snippets.dzone.com/posts/show/4146
      merger = proc { |key,v1,v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      self.merge!(second, &merger)
   end

   def nested_hash(array)
      node = self
      array.each do |i|
         node[i]=Hash.new if node[i].nil?
         node = node[i]
      end 
      self
   end

   def merge_nested_hash!(nested_hash)
      deep_merge!(nested_hash)
   end

   # code basis taken from: "Find every path and it's value in a Hash" by Florian Aßmann,
   # http://snippets.dzone.com/posts/show/3565

   def each_trie_path
      raise ArgumentError unless block_given?
      self.class.each_trie_path(self) { |path, object| yield(path, object) }
   end

   protected
   def self.each_trie_path(object, path = [], &block)  

      if object.is_a?(Hash)
         object.each do |key, value|

            if key == true && value == {}
               if path == [:root]  # special case for empty string: [[:root], {true=>{}}]
                  yield(path, {true=>{}})
                  next
               end
               yield(path, object)
            end

            self.each_trie_path(value, [path , key].flatten, &block)
         end
      else 
         yield(path, object)
      end
   end 

end


class Trie

   @hash = Hash.new.merge_nested_hash!(Hash.new)
   #@hash = Hash.new.merge_nested_hash!({:root=>{}})
   #@hash = Hash.new.merge_nested_hash!(Hash.new.nested_hash([:root]))
   class << self; attr_accessor :hash; end    # Trie.hash

   def initialize
      Trie.hash.merge_nested_hash!({:root=>{}})
   end


   def add_int(int)   # for int >= 0
      ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }  # integer array; ex: [4,6,2]
      ia.unshift(:root).push(true)
      Trie.hash.merge_nested_hash!(Hash.new.nested_hash(ia))
   end

   def matchi(int)  # match integer
      ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }  
      node = Trie.hash.fetch(:root,nil)
      ia.each do |digit|
         node = node[digit]
         #node = node.fetch(digit,nil)
         return false unless node
      end
      node.fetch(true,nil) ? true : false
   end

   def mfpi(int)   # match first part of integer
      ia = int.to_s.scan(/[[:digit:]]/).map { |i| i.to_i }
      node = Trie.hash.fetch(:root,nil)
      ia.each do |digit|
         node = node[digit]
         return false unless node
      end
      return true
   end


   def add_word(word)
      ca = word.split(//u)    # UTF-8 aware character array
      ca.unshift(:root).push(true)
      Trie.hash.merge_nested_hash!(Hash.new.nested_hash(ca))
   end

   def match(word)   # match entire word
      ca = word.split(//u)    
      node = Trie.hash.fetch(:root,nil)
      ca.each do |char|
         node = node[char]
         #node = node.fetch(char,nil)
         return false unless node
      end
      node.fetch(true,nil) ? true : false
   end

   def mfpw(word)   # match first part of word
      ca = word.split(//u)    
      node = Trie.hash.fetch(:root,nil)
      ca.each do |char|
         node = node[char]
         return false unless node
      end
      return true
   end

end

if __FILE__ == $0
  trie = Trie.new
  p Trie.hash

  trie.add_word("bellweather")
  pp Trie.hash

  p trie.match("bellweather")  # will find and return true

  trie.add_word("aerogare")
  p trie.match("aerogare")     # will find and return true
  pp Trie.hash
  p trie.mfpw("aero")          # match first part of word aerogare
end
