require 'rubygems'
require 'mysql'

class Dictionary
  def initialize
    @conn = Mysql.real_connect('localhost','root','179317','test')
  end
  
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
  
  def lookup( word )
    word = escape_word(word)
    sql = %(SELECT word FROM dictionary WHERE word = '#{word}')
    result = @conn.query(sql)
    result.num_rows == 0 ? false : true
  end
  
  def is_word_divisible?( word )
    is_divisible = false
    3.times do |n|
      if lookup( word[0..n+1] ) && lookup( word[n+2..5] )
        puts "*** #{word} is composed of #{word[0..n+1]} and #{word[n+2..5]}"
        is_divisible = true
      end
    end
    is_divisible
  end
  
  def escape_word( word )
    word.gsub(/[']/, "\\\\'")
  end
end

if $0 == __FILE__
  input_file_name = "file.txt"
  number_of_letters = 6
  dict = Dictionary.new
  word_list = dict.read_wordlist( input_file_name, number_of_letters)
  word_list.each do |word|
    dict.is_word_divisible?(word)
  end
end
