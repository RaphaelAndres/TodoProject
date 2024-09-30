defmodule TodoCLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias TodoCLI

  @file_path "todo_list_storage.txt"

  setup do
    if File.exists?(@file_path) do
      File.rm!(@file_path)
    end

    :ok
  end

  test "Assert that function call with 'add' adds a task" do
    assert capture_io(fn -> TodoCLI.main(["add", "Buy milk"]) end) == "Added task: Buy milk\n"
    assert File.read!(@file_path) == "Buy milk"
  end

  test "Assert that function call with 'remove' removes a task" do
    TodoList.add_task("Buy milk")
    assert capture_io(fn -> TodoCLI.main(["remove", "Buy milk"]) end) == "Removed task: Buy milk\n"
    assert File.read!(@file_path) == ""
  end

  test "Assert that function call with 'list' lists all tasks" do
    TodoList.add_task("Buy milk")
    TodoList.add_task("Walk the dog")
    output = capture_io(fn -> TodoCLI.main(["list"]) end)
    assert output == "Tasks:\nBuy milk\nWalk the dog\n"
  end

  test "Assert that function call with 'help' shows usage information" do
    output = capture_io(fn -> TodoCLI.main(["help"]) end)
    assert output == """
    Usage:
      todo add "task name"    - Add a new task
      todo remove "task name" - Remove a task
      todo list               - List all tasks

    """
  end

  test "Assert that function call with invalid command shows usage information" do
    output = capture_io(fn -> TodoCLI.main(["invalid", "command"]) end)
    assert output == """
    Usage:
      todo add "task name"    - Add a new task
      todo remove "task name" - Remove a task
      todo list               - List all tasks

    """
  end
end
