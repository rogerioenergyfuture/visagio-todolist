class Job < ApplicationRecord
    enum status: [ :'a fazer',:'terminado' ]
    belongs_to :todo
end
