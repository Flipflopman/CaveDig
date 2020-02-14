menu={buttons={},screen=0}
menu.buttons.code={"menu.screen=1","closeGame()"} --initGame()

--menu.buttons.code[1]='initGame()' --SKIP WORLD SELECTION

if(ru)then
  menu.buttons.text={"Играть","Выход"}--"Вийди 3вiдси розбiйник"]
else
  menu.buttons.text={"Play","Exit"}
end

function worldList()
  local filesTable =love.filesystem.getDirectoryItems("")
  local output={}
  local j=1
  for i,v in ipairs(filesTable) do
    if love.filesystem.getInfo(v).type=='directory' then
      if v:find("world_") ~= nil then
        output[j]=v
        j=j+1
      end
    end
  end
  return output
end

function menu.buttxy(i,f,t)
  f=f or fonts.menu
  t=t or menu.buttons.text[i]
  local x=(w/2)-(f:getWidth(t)/2)
  local y=(h/2)+(i*f:getHeight())
  return tonumber(x),tonumber(y)
end

function menu.buttwh(i,f)
  f=f or fonts.menu
  local w=f:getWidth(menu.buttons.text[i])
  local h=f:getHeight()
  return w,h
end

function menu.loop()
  if(menu.screen==0)then
    for i=1,table.count(menu.buttons.text) do
      local tm1,tm2=menu.buttxy(i)
      local xm1,xm2=menu.buttwh(i)
      if(isInRect(mx,my,tm1,tm2,tm1+xm1,tm2+xm2) and m1)then
        menu.buttons.code[i]()
      end
    end
  end
  if(menu.screen==1)then

  end
end

function menu.draw()
  if(menu.screen==0)then
    love.graphics.setFont(fonts.title)
    love.graphics.print(gameName,menu.buttxy(-1,fonts.title,gameName))

    for i=1,table.count(menu.buttons.text)do
      love.graphics.setFont(fonts.menu)
      love.graphics.setColor(1,1,1)
      --------------------------------------------------------------
      love.graphics.print(menu.buttons.text[i],menu.buttxy(i))
      --------------------------------------------------------------
      love.graphics.setFont(fonts.default)
    end
  end
  if(menu.screen==1)then
    love.graphics.setFont(fonts.default_b)
    for i=1,table.count(worlds) do
      local tmp_wn1=worlds[i]:gsub('world%_','')
      local tmp_wh1=fonts.default_b:getHeight()
      local tmp_wy1=i*tmp_wh1
      local tmp_ww1=fonts.default_b:getWidth(tmp_wn1)
      local tmp_wx1=w/2-tmp_ww1/2
      love.graphics.print(tmp_wn1,tmp_wx1,tmp_wy1)
      if(isInRect(mx,my,tmp_wx1,tmp_wy1,tmp_ww1+tmp_wx1,tmp_wh1+tmp_wy1) and m1)then
        world.name=tmp_wn1
        initGame()
      end
    end
    love.graphics.setFont(fonts.default)
  end
end

function menu.init()
  for i=1,table.count(menu.buttons.code)do
    menu.buttons.code[i]=loadstring(menu.buttons.code[i])
  end
  if table.count(worldList())<1 then
    initGame()
    chl.f.saveChunk()
    inGame=false
  end
  worlds=worldList()
end
