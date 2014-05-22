require 'ipaddress'

class Subnetter
  def initialize
    user_input; route; subnet
  end

  def user_input
    puts "What class network?"
    @network_class = gets.chomp.to_s.downcase
    puts "What is the starting ip?"
    @ip = gets.chomp.to_s.downcase
    puts "How many subnets?"
    @subnets = gets.chomp.to_i
  end

  def route
    if @network_class == "c"
      @ip = IPAddress "#{@ip}/24"
    elsif @network_class == "b"
      @ip = IPAddress "#{@ip}/16"
    else @network_class == "a"
      @ip = IPAddress "#{@ip}/8"
    end
  end

  def subnet
    output_routes = @ip.split(@subnets)
    bcast = output_routes.map { |i| i.broadcast }
    values = bcast.map do |i|
      [i.first.to_string, i.last.to_string]
    end 
    values.each { |i| puts i[0] + "  =>  " + i[1] }
  end
end

s = Subnetter.new 
