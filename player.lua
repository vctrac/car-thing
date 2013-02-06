
function player(Kr)
	local this={
		x=175, y=sH+70,
		w=41, h=79,
		ace=0, des=0,
		l=100, car=car(Kr),
		pos=3, first=true,
		model=love.filesystem.enumerate("car")
	};
	
	function this:up(dt)
		local up=love.keyboard.isDown("w","up")
		local down=love.keyboard.isDown("s","down")
		local vel=math.ceil(spd/4)
		if up then _var=_var+.1 elseif down then _var=_var-.1 end
		if self.y>460 and first then self.ace=2; end
		if self.x < POS[self.pos]-vel then self.x=self.x+vel;
		elseif self.x>POS[self.pos]+vel then self.x=self.x-vel;
		elseif self.x > POS[self.pos]-vel and self.x < POS[self.pos]+vel then self.x = POS[self.pos];
		end
	end;
	
	function this:draw()
		self.car:draw(self.x,self.y)
	end;

	return this;
end;
