require './application'
COMMAND_MAP = {
  "SET"      => {method_name: "set_value", arg_count: 2},
  "GET"      => {method_name: "get_value", arg_count: 1},
  "DELETE"   => {method_name: "delete_value", arg_count: 1},
  "COUNT"    => {method_name: "count_keys", arg_count: 1},
  "BEGIN"    => {method_name: "begin_transaction", arg_count: 0},
  "COMMIT"   => {method_name: "commit_transaction", arg_count: 0},
  "ROLLBACK" => {method_name: "rollback_transaction", arg_count: 0}
}.freeze

puts "Starting SimpleDB..."

$application = Application.new

def validate_command(command, arguments)
  COMMAND_MAP.keys.include?(command) and arguments.length == COMMAND_MAP[command].dig(:arg_count)
end

def send_command(command, arguments)
  puts $application.public_send(COMMAND_MAP[command].dig(:method_name), *arguments)
end

while true do
  print "> "
  command, *arguments = gets.chomp.split(" ")
  if validate_command(command, arguments)
    send_command(command, arguments)
  else
    puts "Unrecognized Command/Args: #{command} #{arguments.join(' ')}"
    puts File.read("help-text.txt")
  end
end