# README

# Modo desenvolvedor  
  * Ao criar um novo modelo por exemplo:  
    * ```rails g model Post title description ``` 
    * **É importante que copie o arquivo de migration para o diretorio db_shards/migrate**
    * Outro fator importante ao criar um modelo é fazer a **herança do Connection::Factory** como no exemplo a seguir:  
    
    ```ruby
        class Example < Connection::Factory
            include ActiveMethods
        end
    ```
  * Ao Criar um **novo controller** é importante fazer a **herança do InsideController** como no exemplo a seguir:  
  
    ```ruby
    class ExampleController  < Support::InsideController
    ...
    end
    ```

# Como utilizar?
- Para utilizar o Sistema use primeira mente essas tasks(tarefas)  

* Caso não tenha o banco principal
```ruby
  rails db:drop db:create db:migrate setup:create_admin setup:send_models
```
* Obs 
  * *O sistema está configurada para ambientes distintos*  

# Configurando o Modelos  
  * Em caso de **Criação** de novos **Módulos Independentes** - 
    * Logado no sistema como **admin**
        * Na área de criação de modelos -   
            coloque o **nome de exibição e nome da classe**.  
          ```
            Ex: Users - User
          ```  
          
# Configurando o Ambiente
  
  - Existe um arquivo chamado ```database_shared_db.yml``` em **/config/databases**
    - Altere o nome da base de dados para o nome do banco da empresa e entrar em vigor
    - Lembrese de alterar o usuario e senha do banco

- Use as tarefas a seguir para criar o banco de dados  

    ```ruby
      rails shared:setup:db:create shared:setup:db:migrate
    ```

    * Ao criar o banco com base em ```database_shared_db.yml```  
        *  **Importar manualmente** o SQL de Estados e Cidades em db_shards  

    * Entre como Administrador do Sistema e cadastre o Ambiente da Empresa  
      * Obs.: O **nome do banco** deve ser o mesmo colocado em ```database_shared_db.yml```
        porem **sem** o _production, _develpment ou _test.
      * Crie o Admin desse ambiente e Adicione modalidades permitidas para esse Ambiente