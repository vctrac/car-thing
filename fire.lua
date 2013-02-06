fogo = {};
function fogo.new(maxflames,flamelife)
	local this = {};
	for i=1,maxflames do
		local x,y,l = -100,-100,flamelife;
		table.insert(this,{ x = x, y = y, l = l });
	end;
	this.life=flamelife;
	this.fill={255,255,155};
	function this:setlife(v)
		if v then self.life = v else return self.life end
	end;
	function this:draw(X,Y,dir)
		for n,s in ipairs(self) do
			if s.l>51 or s.l<10 then self.fill={255,182,0} else self.fill={255,s.l*5,0} end;
			if not pause then
				s.l = s.l - math.random(3);
				if s.l <= 0 then
					s.x = X + math.random(-1,1);
					s.y = Y;
					s.l = self.life;
				else
					s.y = dir<0 and s.y + math.random(dir,0) or s.y + math.random(dir);
					s.x = s.x + math.random(-3,3);
				end
			end
			love.graphics.setColor(self.fill);
			love.graphics.circle("fill",s.x,s.y,(s.l/10),6);
			--~ love.graphics.setColor(0,0,0,140);					--|Black
			--~ love.graphics.circle("line",s.x,s.y,(s.l/10),6);	--|Border
		end
	end;
	return this;
end
