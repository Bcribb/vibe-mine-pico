function _init()
 player_x=0
 player_y=0
 init_camera()
 update_chunks()
end

function _update()
 update_chunks()
end

function _draw()
 cls(12)
 camera(cam_x,cam_y)
 draw_world()
 camera()
 spr(1,64-4,64-4)
end
