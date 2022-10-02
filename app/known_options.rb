# frozen-string-literal: true

module KnownOptions
  NEW = '--new'
  GIVE = '--give'
  LIST = '--list'
  CHANGE = '--change'
  HELP = ['-h', '--help'].freeze

  ALL = [NEW, GIVE, LIST, CHANGE, HELP].freeze

  TEXTS = {
    NEW => 'Создание нового пароля.',
    GIVE => 'Получить уже имеющийся конкретный пароль.',
    LIST => 'Получить список всех сервисов.',
    CHANGE => 'Изименить существующий пароль.',
    HELP => 'Получить информацию по существующим функциям.'
  }.freeze

  def self.options_list
    ALL.flatten.map { |option| "[#{option}]" }.join(' ')
  end
end
