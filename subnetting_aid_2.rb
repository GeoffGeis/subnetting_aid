require 'ipaddress'

class TheSubNetter

  def initialize(network_class, ip, subnets)
    @network_class = network_class
    @ip = ip
    @subnets = subnets
  end

  def ip_class
    if @network_class == "c"
      IPAddress "#{@ip}/24"
    elsif @network_class == "b"
      IPAddress "#{@ip}/16"
    elsif @network_class == "a"
      IPAddress "#{@ip}/8"
    else
      "Error!"
    end
  end

  def subnet(ip)
    subnets = ip.split(@subnets)
  end

  def ranges(subnets)
    bcast = subnets.map do |i|
      i.broadcast
    end
    bcast.map do |i|
      [i.first.to_string, i.last.to_string]  
    end
  end

end

puts "What class network?"
network_class = gets.chomp.to_s.downcase
puts "What is the ip?"
ip = gets.chomp.to_s.downcase
puts "How many subnets?"
subnets = gets.chomp.to_i

get_subd = TheSubNetter.new(network_class, ip, subnets)
address = get_subd.ip_class
subnets = get_subd.subnet(address)
ranges = get_subd.ranges(subnets)
ranges.each do |i|
  puts i[0] + "  =>  " + i[1]
end