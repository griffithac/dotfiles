require 'rubygems'
require 'awesome_print'
require 'table_print'

AwesomePrint.pry!

def y(obj)
  puts obj.to_yaml
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
