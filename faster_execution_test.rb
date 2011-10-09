require 'rubygems'
require 'active_record'
require 'mysql'
require 'test/unit'
require 'faster_execution3'

class FasterExecutionTest < Test::Unit::TestCase

  INPUT_FILE  = "file_test.txt"
  WORD_LIST   = ['subvert','arrayse','zeroed']
  WORD_LENGTH = 6
  
  def setup
    @conn = Mysql.real_connect('localhost','root','179317','test')
    input_file = File.new( INPUT_FILE , "w")
    WORD_LIST.each do |rec|
      input_file.puts rec
    end
    input_file.close
    @conn.query("DROP TABLE IF EXISTS dictionary")
    @conn.query("CREATE TABLE dictionary (id INT AUTO_INCREMENT, word VARCHAR(255), PRIMARY KEY(id))")
    @conn.query("INSERT INTO dictionary (word) VALUES('zero')")
    @conn.query("INSERT INTO dictionary (word) VALUES('ed')")
    @conn.query("INSERT INTO dictionary (word) VALUES('wide')")
    @conn.query("INSERT INTO dictionary (word) VALUES('st')")
    @conn.query("INSERT INTO dictionary (word) VALUES('bar')")
    @conn.query("INSERT INTO dictionary (word) VALUES('mad')")
    @conn.query("INSERT INTO dictionary (word) VALUES('O\\'')")
    @conn.query("INSERT INTO dictionary (word) VALUES('Dell')")
    @conn.query("CREATE INDEX idx_word ON dictionary(word)")
  end
  
  # I expect only one 6-letters word to be found in file_test.txt. The word 'zeroed'.
  def test_read_wordlist
    dict = Dictionary.new
    assert_respond_to( dict , :read_wordlist )
    assert_equal( ['zeroed'] , dict.read_wordlist(INPUT_FILE, WORD_LENGTH ))
  end
  
  # The word 'zeroed' is composed of 'zero' and 'ed' and is divisible.
  def test_is_word_divisible
    dict = Dictionary.new
    assert_respond_to( dict , :is_word_divisible? )
    assert( dict.is_word_divisible?('zeroed'))
  end
  
  def test_lookup
    dict = Dictionary.new
    assert_respond_to( dict , :lookup )
    assert( dict.lookup('zero') && dict.lookup('ed'))
    assert( dict.lookup("O\'") && dict.lookup('Dell'))
  end
  
  def test_escape_word
    dict = Dictionary.new
    assert_respond_to( dict , :escape_word )
    assert_equal( "O\\'Dell" , dict.escape_word( "O'Dell" ))
  end
end
