# frozen-string-literal: true

require 'faker'
require 'base64'

require_relative 'support'
require_relative 'known_options'

class Generator
  class << self
    def generator
      @@generator ||= Faker::Crypto.unique
    end

    def cipher
      @@cipher ||= OpenSSL::Cipher.new('AES-128-CBC')
    end

    def call
      new.send(:call)
    end
end

  private

  def call
    if KnownOptions::ALL.include?(ARGV.first)
      send("option_#{option_name}".to_sym)
    else
      puts "unknown option: #{ARGV.first}\n"\
      'usage: gen.rb [--new] [--give] [--list] [--change]'
    end
  end

  # Функции для обработки существующих опций
  def option_new
    if exist_services.keys.include?(new_service_name)
      puts('Пароль для данного сервиса уже существует')
      return
    end
    new_password = encode(Generator.generator.md5)

    File.open(Support::DEFAULT_PASSWORD_STORAGE, 'a+') do |passwords_txt|
      passwords_txt.puts Support.new_line(new_service_name, new_password)
    end
  end

  def option_give
    puts exist_services[new_service_name]
  end

  def option_list
    exist_services.keys.each_with_index do |service, i|
      puts "#{i + 1}) #{service}"
    end
  end

  # Чтение существующих записей в файле
  def exist_services
    current_passwords.map do |line|
      end_of_service_name = line.index(Support::DEFAULT_SYMBOL)

      service = line[0...end_of_service_name].chomp(' ')
      password = decode(line[end_of_service_name + 3..line.length].chomp)

      [service, password]
    end.to_h
  end

  def current_passwords
    File.open(Support::DEFAULT_PASSWORD_STORAGE, 'r').readlines
  end

  # Работа с аргументами консоли
  def new_service_name
    ARGV[1].downcase
  end

  def option_name
    string = ARGV.first
    index = string.index(/[a-z]/)
    string[index..-1]
  end

  # Работа с шифрованием паролей
  def encode(str)
    Base64.encode64(str)
  end

  def decode(str)
    Base64.decode64(str)
  end
end

Generator.call
