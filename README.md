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


* Ao criar o banco com base em ```database_shared_db.yml```  
  *  **Importar manualmente** o SQL de Estados e Cidades em db_shards  

> 
* Entre como Administrador do Sistema e cadastre o Ambiente da Empresa
  * Obs.: O **nome do banco** deve ser o mesmo colocado em ```database_shared_db.yml```
    porem **sem** o _production, _develpment ou _test.
  * Crie o Admin desse ambiente e Adicione modalidades permitidas para esse Ambiente

* Em caso de **Criação** de novos Módulos Independentes - 
  * Adicione na área de criação de módulos -   
    coloque o **nome de exibição e nome da classe**.  

  ```ruby
    Ex: Users - User
  ```