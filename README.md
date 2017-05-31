# QuestionsFca

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start a postgresql server, e.g. with `docker run --name questions-postgres -p 5432:5432 -d postgres`.
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

To start the lein dependency

  * Go to folder conexp-server
  * Install dependencies with `lein deps`
  * Start a server by hitting `lein repl` and then entering `(load-file "calc_implications.clj")`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

If you want to restart your application

  * Restart the postgresql server, e.g. with `docker start questions-postgres`
  * Restart the lein server by following the steps above for lein excluding getting dependencies
  * Start the Phoenix endpoint with `mix phoenix.server`

This app has been developped with help of the [Phoenix framework](http://www.phoenixframework.org/)