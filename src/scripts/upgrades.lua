-- upgrade grid ui

-- grid-to-screen offset (centers the grid)
node_ox=48
node_oy=40
node_sp=32

upg_sel=1

function init_upgrades()
 upg_sel=1
end

function get_upg(id)
 for u in all(upgrades) do
  if u.id==id then return u end
 end
end

function is_bought(id)
 return pdata.bought[id]==true
end

function can_buy(id)
 local u=get_upg(id)
 if not u then return false end
 if is_bought(id) then return false end
 if pdata.coins<u.cost then return false end
 -- root node (id==1) always available
 if id==1 then return true end
 -- need at least one adjacent bought
 for a in all(u.adj) do
  if is_bought(a) then return true end
 end
 return false
end

function buy_upgrade(id)
 local u=get_upg(id)
 if not u then return end
 pdata.coins-=u.cost
 pdata.bought[id]=true
end

function calc_stamina()
 local s=stamina_base
 for u in all(upgrades) do
  if is_bought(u.id) and u.stat=="stamina" then
   s+=u.val
  end
 end
 return s
end

-- navigation: find adjacent node in pressed direction
function upg_neighbor(dir_dx,dir_dy)
 local cur=get_upg(upg_sel)
 if not cur then return nil end
 for a in all(cur.adj) do
  local n=get_upg(a)
  if n then
   local dx=n.gx-cur.gx
   local dy=n.gy-cur.gy
   if dx==dir_dx and dy==dir_dy then
    return n.id
   end
  end
 end
 return nil
end

function update_upgrades()
 -- cardinal navigation
 if btnp(0) then
  local n=upg_neighbor(-1,0)
  if n then upg_sel=n end
 elseif btnp(1) then
  local n=upg_neighbor(1,0)
  if n then upg_sel=n end
 elseif btnp(2) then
  local n=upg_neighbor(0,-1)
  if n then upg_sel=n end
 elseif btnp(3) then
  local n=upg_neighbor(0,1)
  if n then upg_sel=n end
 end

 -- purchase
 if btnp(4) then
  if can_buy(upg_sel) then
   buy_upgrade(upg_sel)
  end
 end

 -- start game run (need at least one upgrade)
 if btnp(5) and calc_stamina()>0 then
  set_state("game")
 end
end

function node_sx(u)
 return node_ox+u.gx*node_sp
end

function node_sy(u)
 return node_oy+u.gy*node_sp
end

function draw_upgrades()
 cls(0)
 camera()

 -- title
 print("upgrades",1,1,7)

 -- coin count
 local cs=coins_icon..pdata.coins
 print(cs,128-#cs*4,1,7)

 -- connection lines
 for u in all(upgrades) do
  local sx=node_sx(u)+4
  local sy=node_sy(u)+4
  for a in all(u.adj) do
   if a>u.id then
    local n=get_upg(a)
    if n then
     line(sx,sy,node_sx(n)+4,node_sy(n)+4,5)
    end
   end
  end
 end

 -- nodes
 for u in all(upgrades) do
  local sx=node_sx(u)
  local sy=node_sy(u)
  local bought=is_bought(u.id)
  local avail=can_buy(u.id)

  -- border/highlight
  local bc=1
  if bought then
   bc=11
  elseif avail then
   bc=6
  end

  rect(sx-1,sy-1,sx+8,sy+8,bc)

  -- sprite
  if bought or avail then
   spr(spr_upgrade,sx,sy)
  else
   -- locked: draw dimmed
   rectfill(sx,sy,sx+7,sy+7,1)
  end

  -- selection cursor
  if u.id==upg_sel then
   rect(sx-2,sy-2,sx+9,sy+9,7)
  end
 end

 -- info panel for selected node
 local sel=get_upg(upg_sel)
 if sel then
  local iy=62
  print(sel.name,1,iy,7)
  print(sel.desc,1,iy+8,6)
  if is_bought(sel.id) then
   print("owned",1,iy+16,11)
  elseif can_buy(sel.id) then
   local cost_s
   if sel.cost==0 then
    cost_s="free"
   else
    cost_s=coins_icon..sel.cost
   end
   print(cost_s,1,iy+16,10)
   print("o to buy",1,iy+24,6)
  else
   local cost_s=coins_icon..sel.cost
   print(cost_s,1,iy+16,8)
   print("locked",1,iy+24,8)
  end
 end

 -- play hint
 if calc_stamina()>0 then
  print("x to play",80,120,6)
 else
  print("buy an upgrade!",56,120,8)
 end
end
