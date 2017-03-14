# encoding: utf-8
class WordReader
  def read_from_file(file_name)
    lines = File.readlines(file_name)
    return lines.sample.chomp
  end
end