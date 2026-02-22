-- 1d value noise using srand/rnd for deterministic hashing
function pnoise(x)
 local xi=flr(x)
 local xf=x-xi
 xf=xf*xf*(3-2*xf)
 srand(xi+world_seed)
 local a=rnd()
 srand(xi+1+world_seed)
 local b=rnd()
 return a+(b-a)*xf
end

-- fractional brownian motion (layered octaves)
function fbm(x,oct)
 local val,amp,freq,tot=0,1,1,0
 for i=1,oct do
  val+=pnoise(x*freq)*amp
  tot+=amp
  amp*=0.5
  freq*=2
 end
 return val/tot
end

-- terrain surface height for a given tile-x
function get_surface_y(wx)
 local h=fbm(wx*noise_freq,noise_oct)
 return flr(surface_base+h*surface_amp*2-surface_amp)
end
