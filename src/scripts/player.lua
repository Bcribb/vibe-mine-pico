function init_player()
 local sy=get_surface_y(0)
 player_x=0
 player_y=(sy-1)*tile_size
end

function update_player()
 local dx,dy=0,0
 if btnp(0) then dx=-1 end
 if btnp(1) then dx=1 end
 if btnp(2) then dy=-1 end
 if btnp(3) then dy=1 end

 if dx==0 and dy==0 then return end

 local tx=flr(player_x/tile_size)+dx
 local ty=flr(player_y/tile_size)+dy

 local t=get_tile(tx,ty)
 if t==t_dirt then
  set_tile(tx,ty,t_air)
 end

 player_x=tx*tile_size
 player_y=ty*tile_size
end
