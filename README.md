### Useful `rake` tasks
```text
rake console             # Start IRB with application environment loaded
rake db:create           # Create the databases at mood-server_development
rake db:drop             # Drop the database at mood-server_development
rake db:migrate          # Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)
rake db:reset            # Drop, create, and migrate the database
rake db:seed             # Populate the database with dummy data by running db/seeds.rb
rake db:test:prepare     # Migrate test database
rake db:version          # Returns the current schema version number
rake generate:migration  # Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks
rake generate:model      # Create an empty model in app/models, e.g., rake generate:model NAME=User
rake generate:spec       # Create an empty model spec in spec, e.g., rake generate:spec NAME=user
```
