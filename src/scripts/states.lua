game_state=""

function set_state(s)
 game_state=s
 if s=="menu" then
  enter_menu()
 elseif s=="incremental" then
  enter_incremental()
 elseif s=="game" then
  enter_game()
 end
end

-- menu state

function enter_menu()
end

function update_menu()
 if btnp(4) then
  set_state("incremental")
 end
end

function draw_menu()
 cls(0)
 camera()
 print("vibe mine",46,50,7)
 print("press o to start",32,70,6)
end

-- incremental state

function enter_incremental()
end

function update_incremental()
 if btnp(4) then
  set_state("game")
 end
end

function draw_incremental()
 cls(0)
 camera()
 print("upgrades",48,50,7)
 print("press o to continue",26,70,6)
end

-- game state

function enter_game()
 world_seed=flr(rnd(0x7fff))
 reset_chunks()
 init_player()
 init_camera()
 update_chunks()
end

function update_game()
 update_player()
 update_camera()
 update_chunks()
end

function draw_game()
 cls(12)
 camera(cam_x,cam_y)
 draw_world()
 spr(spr_player,player_x,player_y)
 camera()
end

-- dispatch

function update_state()
 if game_state=="menu" then
  update_menu()
 elseif game_state=="incremental" then
  update_incremental()
 elseif game_state=="game" then
  update_game()
 end
end

function draw_state()
 if game_state=="menu" then
  draw_menu()
 elseif game_state=="incremental" then
  draw_incremental()
 elseif game_state=="game" then
  draw_game()
 end
end
