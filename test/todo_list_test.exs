defmodule TodoTest do
  use ExUnit.Case
  alias TodoList

  @file_path "todo_list_storage.txt"

  setup do
    # Ensure the storage file is deleted before each test
    if File.exists?(@file_path) do
      File.rm!(@file_path)
    end

    :ok
  end

  test "Assert that function call with add, adds a task to the list" do
    TodoList.add_task("Buy milk")
    assert File.read!(@file_path) == "Buy milk"
  end

  test "Assert that function call with remove, removes a task from the list" do
    TodoList.add_task("Buy milk")
    TodoList.add_task("Walk the dog")
    TodoList.remove_task("Buy milk")
    assert File.read!(@file_path) == "Walk the dog"
  end

  test "Assert that function call with list, returns all tasks" do
    TodoList.add_task("Buy milk")
    TodoList.add_task("Walk the dog")
    assert TodoList.list_tasks() == ["Buy milk", "Walk the dog"]
  end

  test "Assert that adding than removing an item handle empty list correctly" do
    TodoList.add_task("Buy milk")
    TodoList.remove_task("Buy milk")
    assert File.read!(@file_path) == ""
  end

  test "Assert that list returns an empty list when there are no tasks" do
    assert TodoList.list_tasks() == []
  end
end
