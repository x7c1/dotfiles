
Flow = Struct.new :src, :dst

to_flow = -> name do
  on = -> dir { "#{dir}/#{name}" }
  Flow.new on[Dir::pwd], on[ENV["HOME"]]
end

create_symbolic_link = -> flow do
  puts line = "ln -s #{flow.src} #{flow.dst}"
  `#{line}`
end

targets = case
  when ARGV == ["--all"]
    [
      ".oh-my-zsh-custom",
      ".peco",
      ".screenrc",
      ".vimrc",
      ".zshrc",
      ".zshrc.common",
      ".zshrc.oh-my-zsh",
      ".zshrc.peco",
    ]
  else
    ARGV.select{ |x| !x.start_with? "--" }
  end

targets.map(&to_flow).each &create_symbolic_link

