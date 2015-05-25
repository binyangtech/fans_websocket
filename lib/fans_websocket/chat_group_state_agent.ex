defmodule FansWebsocket.ChatGroupStateAgent do
  def start_link do
    room_user_map = Map.new
    Agent.start_link(fn -> room_user_map end, name: __MODULE__)
    {:ok, self}
  end

  def put(room,person) do
    {:ok, people} = get(room)
    people = Set.put people, person
    Agent.update(__MODULE__, fn room_user_map ->
      Map.put room_user_map, room, people
    end)
    {:ok, people}
  end

  def delete(room, person) do
    {:ok, people} = get(room)
    people = Set.delete people, person
    Agent.update(__MODULE__, fn room_user_map ->
      Map.put room_user_map, room, people
    end)
    {:ok, people}
  end

  def get(room) do
    Agent.get(__MODULE__, fn room_user_map ->
      people = Map.get room_user_map, room, HashSet.new
      {:ok, people}
    end)
  end

end
