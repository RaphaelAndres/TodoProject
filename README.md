# Todo project

**TODO: This is a simple program, to add TODO tasks in a file, and to serve as a POC of elixir and File handling.**


In order to execute this, you need to run 
mix escript.build 
on a terminal, this will create a executable todo file.
On your terminal, execute ./todo help, this will show all 3 capabilities of this simple program.

you can run
./todo add "task name"     - Add a new task
./todo remove "task name"  - Remove a task
./todo list                - List all tasks

**Unit tests**
To execute unit tests, run:
mix test