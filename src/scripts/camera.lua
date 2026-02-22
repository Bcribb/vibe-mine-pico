cam_x=0
cam_y=0

function init_camera()
 cam_x=player_x-60
 cam_y=player_y-60
end

function draw_world()
 local tx0=flr(cam_x/tile_size)
 local ty0=flr(cam_y/tile_size)
 for tx=tx0,tx0+16 do
  for ty=ty0,ty0+16 do
   local t=get_tile(tx,ty)
   if t==t_dirt then
    spr(spr_dirt,tx*tile_size,ty*tile_size)
   end
  end
 end
end
