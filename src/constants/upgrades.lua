-- upgrade grid nodes
-- adj = connected node ids (cardinal nav)
upgrades={
 {id=1,name="vigor i",desc="*+5",cost=0,stat="stamina",val=5,gx=0,gy=0,adj={2}},
 {id=2,name="vigor ii",desc="*+5",cost=5,stat="stamina",val=5,gx=1,gy=0,adj={1,3,4}},
 {id=3,name="vigor iii",desc="*+10",cost=10,stat="stamina",val=10,gx=1,gy=-1,adj={2}},
 {id=4,name="prospector",desc="tiles+1",cost=10,stat="tile_value",val=1,gx=1,gy=1,adj={2}},
}
