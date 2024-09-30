defmodule TodoCLI do
  def main(args) do
    args
    |> parse_args()
    |> process_command()
  end

  defp parse_args(args) do
    case args do
      ["add", task] -> {:add, task}
      ["remove", task] -> {:remove, task}
      ["list"] -> :list
      _ -> :help
    end
  end

  defp process_command({:add, task}) do
    TodoList.add_task(task)
    IO.puts("Added task: #{task}")
  end

  defp process_command({:remove, task}) do
    TodoList.remove_task(task)
    IO.puts("Removed task: #{task}")
  end

  defp process_command(:list) do
    tasks = TodoList.list_tasks()
    IO.puts("Tasks:")
    Enum.each(tasks, &IO.puts/1)
  end

  defp process_command(:help) do
    IO.puts("""
    Usage:
      todo add "task name"    - Add a new task
      todo remove "task name" - Remove a task
      todo list               - List all tasks
    """)
  end
end
