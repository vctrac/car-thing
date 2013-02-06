function Road()
	local a={}
	for i=1,80 do
		table.insert(a,{x=math.random(sW),y=math.random(sH)});
	end
	function a:up()
		for i,k in ipairs(a) do
			k.y=k.y+spd;
			if k.y> sH then k.x = math.random(sW); k.y=math.random(-sH,-10); end
		end
	end
	function a:draw()
		love.graphics.setColor(31,31,31);
		love.graphics.rectangle("fill",80,0,180,600);
		love.graphics.setColor(255,255,255,120);
		love.graphics.rectangle("line",78,0,2,600);
		love.graphics.setColor(255,255,255,120);
		love.graphics.rectangle("line",260,0,2,600);
		love.graphics.setColor(155,155,0,20);
		love.graphics.rectangle("line",166,0,2,600);
		love.graphics.setColor(155,155,0,20);
		love.graphics.rectangle("line",172,0,2,600);
		love.graphics.setColor(110,110,110);
		for i,k in ipairs(a) do
			love.graphics.point(k.x,k.y);
		end
	end
	return a;
end;

function forest(maxtree)
	local a={};
	local W=(sW/2)-(treeImg[1]:getWidth()/2);
	local H=(sH/2)-(treeImg[1]:getHeight()/2);
	for i=0,maxtree do
		a[i]={};
		if i%2~=0 then
			a[i].x=a[i-1].x+math.random(265,300);
			a[i].y=a[i-1].y+math.random(-10,10);
		else
			a[i].x=math.random(-40,0);
			a[i].y=i*60
		end
	end;
	function a:up()
		for i,k in ipairs(a) do
			k.y=k.y+spd;
			if k.y > sH then
				k.y=k.y-(sH+100);
				if i%2~=0 then
					a[i].x=a[i-1].x+math.random(255,300);
				else
					a[i].x=math.random(-30,0);
				end
			end
		end
	end;
	function a:draw()
		lg.setColor(0,0,0,140);
		for i,k in ipairs(a) do
			lg.circle("fill",k.x+30,k.y+50,45,12);
		end
		lg.setColor(90,150,90);
		for i,k in ipairs(a) do
			lg.draw(treeImg[1],k.x,k.y);
		end
		for i,k in ipairs(a) do
			local x=(k.x-W)*.05;
			local y=(k.y-H)*.05;
			lg.draw(treeImg[2],k.x+x,k.y+y);
		end
		for i,k in ipairs(a) do
			local x=(k.x-W)*.1;
			local y=(k.y-H)*.1;
			lg.draw(treeImg[3],k.x+x,k.y+y);
		end
	end;
	return a;
end;
