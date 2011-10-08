require 'test/unit' 
require 'easy_to_read'

class EasyToReadTest < Test::Unit::TestCase

  INPUT_FILE = "file_test.txt"
  DICTIONARY = "dictionary_test.txt"

  def setup
    input_file = File.new( INPUT_FILE , "w")
    ['subvert','arrayse','zeroed'].each do |rec|
      input_file.puts rec
    end
    input_file.close
    dictionary = File.new(DICTIONARY,"w")
    ['sub','vert','zero','ed'].each do |rec|
      dictionary.puts rec
    end
    dictionary.close
  end

  def teardown
    #puts "nothing to teardown"
  end
  
  def test_read_wordlist
    input_file = INPUT_FILE
    word_length = 6
    assert_equal(1, read_wordlist(input_file, word_length).size)
  end
  
  def test_get_dictionary
    assert_equal(4, get_dictionary(DICTIONARY).size)
  end
  
  def test_if_a_word_is_found_in_the_dictionary
    word = 'zeroed'
    assert( is_a_word?( word[0..3] , DICTIONARY ))
    assert( is_a_word?( word[4..5] , DICTIONARY ))
  end
end
