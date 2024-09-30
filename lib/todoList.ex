defmodule TodoList do
  @file_path "todo_list_storage.txt"

  def add_task(task) do
    tasks = load_tasks()
    new_tasks = Map.put(tasks, task, true)
    save_tasks(new_tasks)
    :ok
  end

  def remove_task(task) do
    tasks = load_tasks()
    new_tasks = Map.delete(tasks, task)
    save_tasks(new_tasks)
    :ok
  end

  def list_tasks do
    load_tasks()
    |> Map.keys()
  end

  defp load_tasks do
    case File.read(@file_path) do
      {:ok, content} ->
        content
        |> String.split("\n", trim: true)
        |> Enum.reduce(%{}, fn task, acc -> Map.put(acc, task, true) end)
      {:error, :enoent} -> %{}  # File not found
      {:error, _reason} -> %{}  # Other errors
    end
  end

  defp save_tasks(tasks) do
    contents = tasks
    |> Map.keys()
    |> Enum.join("\n")

    File.write!(@file_path, contents)
  end
end
