require 'rubygems'
require 'mysql'
require 'sort/trie_structure'
#
# This program read file.txt and extract all the six-letters words that are
# a concatenation of two words.
#
# The MySQL dictionary table contains of list of valid words.
#
# Example: widest is composed of "wide" + "st"
#          zeroed is composed of "zero" + "ed"
#
class Dictionary
  def initialize
    @conn = @conn = Mysql.real_connect('localhost','root','179317','test')
  end
  
  #@Desc: This method load into an array the content of the filt.txt
  #@Return: An array of word
  def read_wordlist
    wordlist = []
    file = File.new("file.txt", "r")
    while (line = file.gets)
      if line.chomp.size == 6 and line.index(/'/).nil?
        wordlist << line
      end
    end
    file.close
    wordlist
  end

  def build_trie_structure
    @trie = Trie.new
    @trie.add_word("wide")
    @trie.add_word("st")
    @trie.add_word("zero")
    @trie.add_word("ed")
  end
  
  #@Desc: A lookup is made to the dictionary table
  #Expected: A word that does not contain the ' character
  #@Return: true if the word is found
  def is_a_word?( word )
    @trie.match( word )
  end
end

if $0 == __FILE__
  d = Dictionary.new
  d.build_trie_structure
  wordlist_array = d.read_wordlist
  wordlist_array.each do |word|
    3.times do |n|
      if d.is_a_word?(word[0..n+1]) && d.is_a_word?(word[n+2..5])
        puts word.chomp + ": is composed of " + word[0..n+1] + " + " + word[n+2..5]
      end
    end
  end
end
