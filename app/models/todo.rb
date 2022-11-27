class Todo < ApplicationRecord
    enum status: [ :'ativo',:'inativo' ] 
    has_many :jobs, dependent: :delete_all
end
