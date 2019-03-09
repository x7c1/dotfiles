require 'erb'

def to_json description:, modifier:, hotkey:
  file = File.read 'with-modifier.json.erb'
  template = ERB.new(file, nil, '<>')
  template.result binding
end

def to_py src:, dst:
  file = File.read 'with-modifier.py.erb'
  template = ERB.new(file, nil, '<>')
  template.result binding
end

def to_contents modifier, keymap
  keymap.map do |key, dst|
    label = key.to_s
    src = "#{modifier}+#{label}"
    {
      py: {
        src: src,
        dst: dst,
      },
      json: {
        description: "#{src} -> #{dst}",
        modifier: modifier,
        hotkey: label,
      },
    }
  end
end

def seeds_from contents
  contents.map do |content|
    modifier = content[:json][:modifier].match(/<(\w+)>/) {|m| m[1]}
    hotkey = content[:json][:hotkey]
    label = "#{modifier}_#{hotkey}"
    [
      {
        filename: ".#{label}.json",
        content: to_json(content[:json]),
      },
      {
        filename: "#{label}.py",
        content: to_py(content[:py]),
      },
    ]
  end.flatten
end

def plant on, modifier:, keymap:
  write = -> seed do
    open("#{on}/#{seed[:filename]}", 'w') do |file|
      file << seed[:content]
    end
  end
  contents = to_contents(modifier, keymap)
  seeds_from(contents).each &write
end

plant './with_ctrl',
  modifier: "<ctrl>",
  keymap: {
    :a => '<home>',
    :b => '<left>',
    :d => '<delete>',
    :e => '<end>',
    :f => '<right>',
    :h => '<backspace>',
    :n => '<down>',
    :p => '<up>',
  }

plant './with_alt',
  modifier: "<alt>",
  keymap: {
    :a => '<ctrl>+a',
    :f => '<ctrl>+f',
    :n => '<ctrl>+n',
  }

