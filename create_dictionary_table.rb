require 'rubygems'
require 'mysql'
class CreateDictionaryTable 
  def initialize
    puts "***** initialize *****"
    @conn = Mysql.real_connect('localhost','root','179317','test')
  end
  
  def create
    puts "***** create *****"
    @conn.query("create table dictionary (id int auto_increment, word varchar(255), primary key(id)) engine=INNODB;")
    @conn.query("insert into dictionary (word) values('zero')")
    @conn.query("insert into dictionary (word) values('ed')")
    @conn.query("insert into dictionary (word) values('wide')")
    @conn.query("insert into dictionary (word) values('st')")
    @conn.query("create index idx_word on dictionary(word)")
  end
end

if __FILE__ == $0
  dict = CreateDictionaryTable.new
  dict.create
end
