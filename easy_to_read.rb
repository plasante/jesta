#
# This program read file.txt and extract all the six-letters words that are
# a concatenation of two words.
#
# dictionary.txt contains of list of valid words.
#
# Example: widest is composed of "wide" + "st" and will be selected
#          zeroed is composed of "zero" + "ed" and will be selected
#

#@Desc: This method reads file.txt that contains words to be searched.
#@Return: a wordlist array to be searched.
def read_wordlist( file_name , word_length )
  wordlist = []
  file = File.new(file_name, "r")
  while (line = file.gets)
    if line.chomp.size == word_length
      wordlist << line.chomp
    end
  end
  file.close
  wordlist
end

#@Desc: This method reads into an array the file dictionary.txt
#@Return: an array of dictionary words
def get_dictionary( dictionary )
  file = File.new( dictionary , "r" )
  dictionary = []
  while (line = file.gets)
    dictionary << line.chomp
  end
  dictionary
end

#@Desc: This method scan an array of words
#@Return: true if word is found in the dictionary
def is_a_word?( word , dictionary )
  dictionary = get_dictionary( dictionary )
  dictionary.each do |entry|
    if entry == word
      return true
    end
  end
  return false
end

if $0 == __FILE__
  wordlist_array = read_wordlist("file.txt",7)
  dictionary = "dictionary.txt"
  wordlist_array.each do |word|
    3.times do |n|
      if is_a_word?(word[0..n+1] , dictionary) && is_a_word?(word[n+2..5], dictionary)
        puts word[0..n+1] + " " + word[n+2..5]
      end
    end
  end
end
