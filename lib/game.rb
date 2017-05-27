# encoding: utf-8
require "unicode_utils/downcase"
class Game
  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(word)
    if word == nil || word == ""
      abort "Для игры введите загаданное слово в качестве аргумента при " \
        "запуске программы"
    end
    word = UnicodeUtils.downcase(word)
    return word.encode('UTF-8').split("")
  end

  def status
    @status
  end

  def next_step(letter)
    letter = UnicodeUtils.downcase(letter)
    return if @status == -1 || @status == 1
    return if @good_letters.include?(letter) || @bad_letters.include?(letter)
    if @letters.include?(letter)
      @good_letters << letter
      @status = 1 if @good_letters.uniq.sort == @letters.uniq.sort
    else
      @bad_letters << letter
      @errors += 1
      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""
    letter = STDIN.gets.encode("UTF-8").chomp while letter == ""
    letter = UnicodeUtils.downcase(letter)
    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
