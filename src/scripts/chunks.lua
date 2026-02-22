chunks={}

function chunk_key(cx,cy)
 return cx..","..cy
end

function gen_chunk(cx,cy)
 local c={}
 for lx=0,chunk_w-1 do
  c[lx]={}
  local wx=cx*chunk_w+lx
  local sy=get_surface_y(wx)
  for ly=0,chunk_h-1 do
   local wy=cy*chunk_h+ly
   if wy>=sy then
    c[lx][ly]=t_dirt
   else
    c[lx][ly]=t_air
   end
  end
 end
 return c
end

function get_chunk(cx,cy)
 local k=chunk_key(cx,cy)
 if not chunks[k] then
  chunks[k]=gen_chunk(cx,cy)
 end
 return chunks[k]
end

function get_tile(wx,wy)
 local cx=flr(wx/chunk_w)
 local cy=flr(wy/chunk_h)
 local c=chunks[chunk_key(cx,cy)]
 if not c then return t_air end
 local lx=wx-cx*chunk_w
 local ly=wy-cy*chunk_h
 return c[lx] and c[lx][ly] or t_air
end

function update_chunks()
 local pcx=flr(player_x/tile_size/chunk_w)
 local pcy=flr(player_y/tile_size/chunk_h)

 local keep={}
 for cx=pcx-load_dist,pcx+load_dist do
  for cy=pcy-load_dist,pcy+load_dist do
   local k=chunk_key(cx,cy)
   keep[k]=true
   if not chunks[k] then
    chunks[k]=gen_chunk(cx,cy)
   end
  end
 end

 for k in pairs(chunks) do
  if not keep[k] then
   chunks[k]=nil
  end
 end
end
