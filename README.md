# README

- Para utilizar o Sistema use primeira mente essas tasks(tarefas)  

```ruby
  rails db:drop db:create db:migrate setup:create_admin setup:send_models
```
* Obs 
  * *O sistema está configurada para ambientes distintos*  

Nesse caso em:  

> ##### /config/databases  
  - Existe um arquivo chamado ```database_shared_db.yml```
    - Altere o nome da base de dados para o nome do banco da empresa e entrar em vigor
    - Lembrese de alterar o usuario e senha do banco

- Use as tarefas a seguir para criar o banco de dados  

```ruby
  rails shared:setup:db:create shared:setup:db:migrate
```


* ...