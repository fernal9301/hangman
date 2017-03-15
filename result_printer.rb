# encoding: utf-8
class ResultPrinter
  def initialize
    @status_image = []
    current_path = File.dirname(__FILE__)
    counter = 0
    while counter <= 7 do
      file_name = current_path + "/data/#{counter}.txt"
      if File.exist?(file_name)
        @status_image << File.read(file_name)
      else
        @status_image << "\n[ Изображение не найдено ]\n"
      end
      counter += 1
    end
  end

  def print_status(game)
    cls
    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_letters.join(", ")}"

    print_hangman(game.errors)

    if game.status == -1
      puts "\nВы проиграли :(\n"
      puts "Загаданное слово было: " + game.letters.join("")
      puts
    elsif game.status == 1
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: " + (7 - game.errors).to_s
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""
    letters.each do |letter|
      if good_letters.include?(letter)
        result += letter + " "
      else
        result += "__ "
      end
    end
    return result
  end

  def print_hangman(errors)
    puts @status_image[errors]
  end

  def cls
    system("clear") || system("cls")
  end
end