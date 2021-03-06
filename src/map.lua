
Wall = require("sprites/wall")
Npc = require("sprites/npc")
Group = require("group")
Door = require("sprites/door")
Floor = require("sprites/floor")
Decor = require("sprites/decor")
Torch = require("sprites/torch")
Cartel = require("sprites/cartel")

function Maps(boss)
  local grill = boss.grill
  local boss = boss
  local maps = {}

  function maps.change_map(door_prop)
    love.window.setTitle(door_prop.dest)
    boss.group = maps[door_prop.dest]
    boss.player.x = door_prop.dest_x
    boss.player.y = door_prop.dest_y
  end

  function load_map(level)
    maps[level.name] = Group(maps)
    for i,door in ipairs(level.properties.door) do
      maps[level.name].add(Door(boss,door))
      if maps[door.dest] == nil and not (door.dest == "null") then
        load_map(require("maps/" .. door.dest)) end
    end
    for i,wall in ipairs(level.properties.wall) do maps[level.name].add(Wall(boss,wall)) end
    for i,floor in ipairs(level.properties.floor) do maps[level.name].add(Floor(boss,floor)) end
    for i,npc in ipairs(level.properties.npc) do maps[level.name].add(Npc(boss,npc)) end
    for i,decor in ipairs(level.properties.decor) do maps[level.name].add(Decor(boss,decor)) end
    for i,torch in ipairs(level.properties.torch) do maps[level.name].add(Torch(boss,torch)) end
    for i,cartel in ipairs(level.properties.cartel) do maps[level.name].add(Cartel(boss,cartel)) end
    return group
  end

  load_map(require("maps/spawn"))

  return maps
end

return Maps
