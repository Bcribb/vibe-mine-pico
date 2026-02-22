function _init()
 init_player()
 init_camera()
 update_chunks()
end

function _update()
 update_player()
 update_camera()
 update_chunks()
end

function _draw()
 cls(12)
 camera(cam_x,cam_y)
 draw_world()
 spr(spr_player,player_x,player_y)
 camera()
end
