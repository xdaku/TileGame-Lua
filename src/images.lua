function Spritesheet(grill)
  local spritesheet = {
    quads = {}
  }
  local grill = grill
  local image = love.graphics.newImage("img/basictiles.png")
  local json = require ("json")
  local size = 32
  function get_image(x,y)
    return love.graphics.newQuad(x*size, y*size, size, size, image:getDimensions())
  end

  function spritesheet.draw_image(x,y,quad)
    love.graphics.draw(image, quad, x, y, 0,(grill.tile/size), (grill.tile/size)) -- correct for float to int
  end

  function get_set(x,y)
    local quads = {}
    quads["down"] = {}
    quads["down"]["stand"] = {get_image(1+x,0+y)}
    quads["down"]["walk"] = {get_image(0+x,0+y),get_image(2+x,0+y)}

    quads["right"] = {}
    quads["right"]["stand"] = {get_image(1+x,2+y)}
    quads["right"]["walk"] = {get_image(0+x,2+y),get_image(2+x,2+y)}

    quads["left"] = {}
    quads["left"]["stand"] = {get_image(1+x,1+y)}
    quads["left"]["walk"] = {get_image(0+x,1+y),get_image(2+x,1+y)}

    quads["up"] = {}
    quads["up"]["stand"] = {get_image(1+x,3+y)}
    quads["up"]["walk"] = {get_image(0+x,3+y),get_image(2+x,3+y)}
    return quads
  end

  lines = ""
  for line in io.lines("src/img/basictiles.json") do lines = lines .. line end
  local dict = json.decode(lines)
  for sprite_type in pairs(dict) do
    spritesheet.quads[sprite_type] = {}
    for id in pairs(dict[sprite_type]) do
      if not (id == "_cumment") then
        if sprite_type == "npc" then
          spritesheet.quads[sprite_type][id] = get_set(dict[sprite_type][id]["x"],dict[sprite_type][id]["y"])
        else
          spritesheet.quads[sprite_type][id] = get_image(dict[sprite_type][id]["x"],dict[sprite_type][id]["y"])
        end
      end
    end
  end

  return spritesheet
end

function Images(grill)
  local images = {}
  -- basictiles
  images["basictiles"] = Spritesheet(grill)


  return images
end

return Images
