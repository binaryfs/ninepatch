local loveunit = require("loveunit")
local NinePatch = require("NinePatch")

local image = love.graphics.newImage("simple-rpg-gui.png")
local test = loveunit.newTestCase("NinePatch")

test:group("new()", function ()
  test:run("should create a 9-patch with the given properties", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    test:assertEqual({300, 200}, {patch:getSize()})
    test:assertEqual({20, 30, 40, 50}, {patch:getMargin()})
    test:assertEqual({80, 60}, {patch:getMinSize()})
  end)
end)

test:group("fromOptions()", function ()
  test:run("should create a 9-patch from the given options table", function ()
    local patch = NinePatch.fromOptions{
      texture = image,
      x = 0,
      y = 0,
      width = 300,
      height = 200,
      marginTop = 20,
      marginRight = 30,
      marginBottom = 40,
      marginLeft = 50,
    }
    test:assertEqual({300, 200}, {patch:getSize()})
    test:assertEqual({20, 30, 40, 50}, {patch:getMargin()})
    test:assertEqual({80, 60}, {patch:getMinSize()})
  end)
  test:run("should raise an error if a mandatory option is missing", function ()
    test:assertError(function ()
      local patch = NinePatch.fromOptions{}
    end)
  end)
end)

test:group("setSize()", function ()
  test:run("should set the size of the 9-patch", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    patch:setSize(400, 500)
    test:assertEqual({400, 500}, {patch:getSize()})
  end)
  test:run("should be constrained by the min size", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    patch:setSize(10, 10)
    test:assertEqual({patch:getMinSize()}, {patch:getSize()})
  end)
  test:run("should keep the original size if argument is nil", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    patch:setSize(400, nil)
    test:assertEqual({400, 200}, {patch:getSize()})
    patch:setSize(nil, 500)
    test:assertEqual({400, 500}, {patch:getSize()})
  end)
end)

test:group("getSize()", function ()
  test:run("should initially return the size of the texture quad", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    test:assertEqual({300, 200}, {patch:getSize()})
  end)
end)

test:group("setWidth()", function ()
  test:run("should set the width of the 9-patch", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    patch:setWidth(400)
    test:assertEqual({400, 200}, {patch:getSize()})
  end)
end)

test:group("setHeight()", function ()
  test:run("should set the height of the 9-patch", function ()
    local patch = NinePatch.new(image, 0, 0, 300, 200, 20, 30, 40, 50)
    patch:setHeight(400)
    test:assertEqual({300, 400}, {patch:getSize()})
  end)
end)
