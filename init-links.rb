
Flow = Struct.new :src, :dst

to_flow = -> name do
  on = -> dir { "#{dir}/#{name}" }
  Flow.new on[Dir::pwd], on[ENV["HOME"]]
end

create_symbolic_link = -> flow do
  puts line = "ln -s #{flow.src} #{flow.dst}"
  `#{line}`
end

ARGV.map(&to_flow).each &create_symbolic_link

