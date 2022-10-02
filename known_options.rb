# frozen-string-literal: true

module KnownOptions
  NEW = '--new'
  GIVE = '--give'
  LIST = '--list'
  HELP = ['-h', '--help'].freeze

  ALL = [NEW, GIVE, LIST].freeze

  TEXTS = {
    NEW => 'Создание нового пароля.',
    GIVE => 'Получить уже имеющийся конкретный пароль.',
    LIST => 'Получить список всех сервисов.',
    HELP => 'Получить информацию по существующим функциям.'
  }.freeze
end
