# frozen-string-literal: true

module Support
  DEFAULT_SYMBOL = '=>'
  DEFAULT_PASSWORD_STORAGE = '/home/work/work_dir_1/pass_gen/passwords.txt'

  def self.new_line(service, password)
    [service, DEFAULT_SYMBOL, password].join(' ')
  end
end
