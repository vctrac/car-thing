local IMG={
	{lg.newImage("rcar/G1.png"), lg.newImage("rcar/G2.png"), lg.newImage("rcar/G3.png")},
	{lg.newImage("rcar/B1.png"), lg.newImage("rcar/B2.png"), lg.newImage("rcar/B3.png")},
	{lg.newImage("rcar/R1.png"), lg.newImage("rcar/R2.png"), lg.newImage("rcar/R3.png")}
	};
function randomCar()
	local p=math.random(4)
	local k = { x=POS[p], y=0, w=41, h=80, ace=0, des=0, p=p, car=rcar(math.random(#IMG)) };
	function k:up(P,spd,v)
		
		--local col=getcoll(self,P)
		--if col then
			--if col.side=="D" then k.y=k.y-(P.ace+spd);
			--elseif col.side=="U" then k.y=k.y+P.des+col.y;
			--end
			--if col.side=="L" then k.x=k.x+3+col.x;
			--elseif col.side=="R" then k.x=k.x-3+col.x;
			--end
			--
		--end
		
		if k.x < (POS[k.p]-1.5) then k.x=k.x+3;
		elseif k.x>(POS[k.p]+1.5) then k.x=k.x-3;
		end
		
		k.ace=v;
		k.y=k.y+(k.ace-k.des)+spd;
		
		if k.y>sH+40 then
			k.y=-100;
		elseif k.y<-100 then
			k.y=sH+30;
		end
	end;
	function k:draw()
		k.car:draw(k.x,k.y);
	end;
	return k;
end
function rcar(Kr)
	local a={n=IMG[Kr]};
	local W=(lg.getWidth()/2)-(IMG[1][1]:getWidth()/1.8);
	local H=(lg.getHeight()/2)-(IMG[1][1]:getHeight()/1.8);
	function a:draw(X,Y)
		local x=(X-W)/50;
		local y=(Y-H)/100;
		lg.setColor(0,0,0,120);
		lg.draw(shadow,X-5,Y);
		lg.setColor(255,255,255);
		lg.draw(a.n[1],X,Y);
		lg.draw(a.n[2],X+x,Y+y);
		lg.draw(a.n[3],X+(x*1.5),Y+(y*1.5));
	end
	return a;
end;
