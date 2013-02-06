do
lg = love.graphics;
sW = lg.getWidth();
sH = lg.getHeight();

--require 'fire';
require 'player';
require 'cars';
require 'sick';

end;

function love.load()
	love.graphics.setDefaultImageFilter('nearest','linear');
	font = love.graphics.newFont("Monotone.ttf", 50);
	carImg={ 
		{
			{lg.newImage("car/generic/B1.png"), lg.newImage("car/generic/B2.png"), lg.newImage("car/generic/B3.png")},
			{lg.newImage("car/generic/R1.png"), lg.newImage("car/generic/R2.png"), lg.newImage("car/generic/R3.png")},
			{lg.newImage("car/generic/G1.png"), lg.newImage("car/generic/G2.png"), lg.newImage("car/generic/G3.png")}
		},
		--{
			--{lg.newImage("car/cargo/W1.png"), lg.newImage("car/cargo/W2.png"), lg.newImage("car/cargo/W3.png")},
			--
		--},
		{
			{lg.newImage("car/police/p1.png"), lg.newImage("car/police/p2.png"), lg.newImage("car/police/p3.png")}
		}
	};
	
	Mcar=1
	Pcar=2
	POS  = {77,127,175,219,3}
	
	treeImg={ lg.newImage("img/tree0.png"), lg.newImage("img/tree1.png"), lg.newImage("img/tree2.png")};
	shadow=lg.newImage("img/shadow.png");
	shd  = lg.newImage("img/shd.png");
	
	--Play = player(Pcar);
	Rcar = randomCar();

	trees= forest(12);
	
	MN=Menu();
	
	menu = true;
	pause= false;
	HS.set('score',5)
	HS.load()
	spd  = 0;
	fbg  = lg.newImage("img/logo.png");
	score= 0;
	fadeThing={255,true};
	
	hud=lg.newCanvas();
	road=lg.newCanvas();
	Road();
	
	lg.setBackgroundColor(41,87,14);
	lg.setFont(font);
end;

function love.update(dt)
	if not pause then
		Rcar:up(Play,spd,-3);
		trees:up();
		if not menu then
			--Play:up(dt);
			spd=spd<20 and spd+.01 or 20;
			score=score+.1;
		end
	end
	love.graphics.setCaption("Cars - Somel - FPS: "..tostring(love.timer.getFPS( )))
end;

function love.draw()
	lg.setColor(255,255,255)
	lg.draw(road,78,0)
	if not menu then
		--Play:draw();
		Rcar:draw();
		trees:draw();
		drawinfo();
	else
		Rcar:draw();
		trees:draw();

		MN:draw();
	end
end;

function Menu()
	local a={};
		a.cur=1;
		a.fst={true,false,255};
		a.option=1;
		a.grg={rot=0, scl=1};

	function a:draw()
		if a.fst[1] then
			lg.setColor(255,255,255,a.fst[3]);
			lg.draw(fbg);
			if a.fst[2] then
				if a.fst[3]>=5 then a.fst[3]=a.fst[3]-5
				else a.fst[1]=false; a.cur=1; end
			else lg.setColor(255,255,255,fade(60,200,2)); lg.printf("Enter",0,540,350,"center"); end
			
		elseif menu then
			if a.option==1 then
			
				lg.setColor(0,0,0,140);
				lg.rectangle("fill",0,200,350,200);
				lg.setColor(0,0,0);
				lg.rectangle("line",0,200,350,200);
				if a.cur==1 then lg.setColor(100,100,255); lg.line(0,247,130,247); lg.line(220,247,350,247); lg.printf("p l a y",0,210,350,"center");
				elseif a.cur==2 then lg.setColor(100,255,100); lg.line(0,287,102,287) lg.line(245,287,350,287); lg.printf("g a r a g e",0,250,350,"center");
				elseif a.cur==3 then lg.setColor(255,100,100); lg.line(0,327,117,327) lg.line(235,327,350,327); lg.printf("s c o r e",0,290,350,"center");
				elseif a.cur==4 then lg.setColor(255,255,100); lg.line(0,367,130,367) lg.line(220,367,350,367); lg.printf("q u i t",0,330,350,"center"); end
				lg.setColor(100,100,100,fade(60,200,1));
				if a.cur~=1 then lg.printf("play",0,210,350,"center"); end
				if a.cur~=2 then lg.printf("garage",0,250,350,"center"); end
				if a.cur~=3 then lg.printf("score",0,290,350,"center"); end
				if a.cur~=4 then lg.printf("quit",0,330,350,"center"); end
				if a.scr_var then Scores() end
				
			elseif a.option==2 then
				if love.keyboard.isDown("w") then MN.grg.scl=MN.grg.scl< 1.5 and MN.grg.scl+.02 or 1.5;
				elseif love.keyboard.isDown("s") then MN.grg.scl=MN.grg.scl> 1 and MN.grg.scl-.02 or 1; end
				a.grg.rot=a.grg.rot+.5;
				lg.setColor(0,0,0)
				lg.rectangle("fill",0,0,sW,sH)
				for i=1,25*a.grg.scl do
					lg.setColor(255,255,255,2)
					lg.circle("fill",sW/2,sH/2,i*5,26)
				end
				lg.setColor(0,0,0,120);
				lg.draw(shd,sW/2,(sH/2)+(7+a.grg.scl),math.rad(a.grg.rot),a.grg.scl,a.grg.scl,20,40)
				lg.setColor(255,255,255)
				lg.draw(carImg[Mcar][Pcar][1],sW/2,sH/2,math.rad(a.grg.rot),a.grg.scl,a.grg.scl,20,40)
				lg.draw(carImg[Mcar][Pcar][2],sW/2,(sH/2)-(4+a.grg.scl),math.rad(a.grg.rot),a.grg.scl,a.grg.scl,20,40)
				lg.draw(carImg[Mcar][Pcar][3],sW/2,(sH/2)-(7+a.grg.scl),math.rad(a.grg.rot),a.grg.scl,a.grg.scl,20,40)
				lg.setColor(155,155,155)
				--lg.print(Play.model[Mcar],260,160)
				lg.print("Zoom  : w - s",10,490)
				lg.print("Car    : left - right",10,520)
				lg.print("Color  : up - down",10,550)
				for i=1,#carImg[Mcar] do lg.print("°",260+i*12,200) end
				
			elseif a.option==3 then
			
				lg.setColor(0,0,0)
				lg.rectangle("fill",0,0,sW,sH)
				lg.setColor(255,255,255)
				lg.printf("TOP 5",0,120,sW,"center")
				for i = 1, HS.places do
					lg.printf(HS.scores[i][2].." . . . . . "..HS.scores[i][1],0,160+i*40,sW,"center" )
				end
				
			end
		end
	end
	return a;
end;

function love.keypressed(k)
	if menu then
		if MN.option==1 then
			if k=="return" then
				if MN.fst[1] then MN.fst[2]=true;
				else
					if MN.cur==1 then menu=false; score=0;
					elseif MN.cur==2 then MN.option=2;
					elseif MN.cur==3 then MN.option=3; 
					elseif MN.cur==4 then HS.save(); love.event.quit(); end
				end
			elseif k=="up" or k=="w" or k=="z" then MN.cur=MN.cur>1 and MN.cur-1 or 4;
			elseif k=="down" or k=="s" then MN.cur=MN.cur<4 and MN.cur+1 or 1; end
			if k=="r" then love.load() end;
			
		elseif MN.option==2 then
			
			if k=="up" then Pcar=Pcar<#carImg[Mcar] and Pcar+1 or 1;
			elseif k=="down" then Pcar=Pcar>1 and Pcar-1 or #carImg[Mcar]; end
			if k=="right" then Mcar=Mcar<#carImg and Mcar+1 or 1; Pcar=1;
			elseif k=="left" then Mcar=Mcar>1 and Mcar-1 or #carImg; Pcar=1; end
		end
		
	else
		if k=="return" then pause=not pause;
		--elseif k=="a" or k=="left" or k=="q" then Play.pos=Play.pos>1 and Play.pos-1 or 1;
		--elseif k=="d" or k=="right" then Play.pos=Play.pos<4 and Play.pos+1 or 4;
		end
	end
	if k=="escape" then
		if not menu then HS.add(string.upper(string.sub(string.gsub("$USER", "%$(%w+)", os.getenv),1,3)),math.floor(score)); end
		--Play=player(Pcar);
		menu=true; pause=false;
		spd=0; MN.option=1;
	end
end;

function coll(x,y,w,h, x2,y2,w2,h2)
	return x<=(x2+w2) and (x+w)>=x2 and y<=(y2+h2) and (y+h)>=y2;
end;

function getcoll(a, b)
	if coll(a.x, a.y, a.w, a.h, b.x, b.y, b.w, b.h) then
		local left = b.x - (a.x + a.w)
		local right = (b.x + b.w) - a.x
		local up = b.y - (a.y + a.h)
		local down = (b.y + b.h) - a.y
		local table = {}--pxside = "",pyside = ""}
		
		table.x = math.abs(left) < right and left or right;
		table.y = math.abs(up) < down and up or down;
		table.xside = table.x == left and "R" or "L";
		table.yside = table.y == up and "D" or "U";
		
		--if a.y+a.h <= b.y+(b.h/3) then
			--table.pxside = "B";
		--elseif a.y > b.y+(b.h-(b.h/3)) then
			--table.pxside = "T";
		--end
		--
		--if a.x+a.w <= b.x+(b.w/3) then
			--table.pyside = "R";
		--elseif a.x > b.x+(b.w-(b.w/3)) then
			--table.pyside = "L";
		--end
		
		if math.abs(table.x) < math.abs(table.y) then
			table.y = 0;
			table.side = table.xside;--table.pxside..table.xside;
			table.hor = true;
		else
			table.x = 0;
			table.side = table.yside;--table.yside..table.pyside;
			table.ver = true;
		end
		
		return table;
	else
		return false;
	end
end

function dist(x1,y1,x2,y2)
  local dx,dy=(x2-x1),(y2-y1);
  return math.sqrt(math.pow(dx,2)+math.pow(dy,2));
end;

function drawinfo()
	lg.setCanvas(hud)
		lg.setColor(0,0,0);
		lg.circle("fill",0,30,66,30)
		lg.setColor(spd*12,250-spd*12,0);
		lg.circle("line",0,30,60,30)
		lg.arc( "fill", 0, 30, 56, 0,(spd/math.pi)/4, 30 )
		lg.setColor(90,90,200);
		lg.circle("line",0,30,66,30)
		lg.line(67,31,sW,31);
		lg.setColor(0,0,0);
		lg.circle("fill",0,30,46,30)
		lg.rectangle("fill",0,0,sW,30);
	lg.setCanvas()

	lg.setColor(255,255,255,200)
	lg.draw(hud,sW,sH,0,-1,-1)

	--lg.setColor(0,0,0);
	--lg.circle("fill",sW,sH-30,66,30)
	--lg.setColor(spd*12,250-spd*12,0);
	--lg.circle("line",sW,sH-30,60,30)
	--lg.arc( "fill", sW, sH-30, 56, 3.1,3.1+(spd/math.pi)/4, 30 )
	--lg.setColor(90,90,200);
	--lg.circle("line",sW,sH-30,66,30)
	--lg.line(0,570,283,570);
	--lg.setColor(0,0,0);
	--lg.circle("fill",sW,sH-30,46,30)
	--lg.rectangle("fill",0,570,sW,30);
	--no canvas /\

	lg.setColor(255,255,255);
	lg.printf(math.floor(score),0,557,350,"center");
	lg.printf(math.floor(spd*10),0,sH-70,sW,"right")
	lg.printf("kmh",0,557,sW,"right")
	--miles = math.floor(spd*10*0.62)
	if pause then
		lg.setColor(0,0,0,fade(50,200,1));
		lg.rectangle("fill",0,0,sW,sH);
		lg.setColor(255,255,255,fade(50,200,1));
		lg.printf("PAUSED",0,263,350,"center");
	end
end;

function Road()
	lg.setCanvas(road)
		love.graphics.setColor(31,31,31);
		love.graphics.rectangle("fill",0,0,180,sH);
		love.graphics.setColor(255,255,255,110);
		love.graphics.rectangle("line",0,0,2,sH);
		love.graphics.rectangle("line",178,0,2,sH);
		love.graphics.setColor(155,155,0,20);
		love.graphics.rectangle("line",88,0,2,sH);
		love.graphics.rectangle("line",96,0,2,sH);
	lg.setCanvas()
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

function fade(min,max,V)
	if fadeThing[2] then
		fadeThing[1]=fadeThing[1]<max and fadeThing[1]+V or 180;
		if fadeThing[1]==180 then fadeThing[2]=false end
	else
		fadeThing[1]=fadeThing[1]>min and fadeThing[1]-V or 50;
		if fadeThing[1]==50 then fadeThing[2]=true end
	end
	return fadeThing[1];
end

function car(Kr)
	local a={n=carImg[Mcar][Kr]};
	local W=(lg.getWidth()/2)-(41/1.8);
	local H=(lg.getHeight()/2)-(79/1.8);
	function a:draw(X,Y)
		local x=(X-W)/50;
		local y=(Y-H)/100;
		lg.setColor(0,0,0,120);
		lg.draw(shadow,X-5,Y);
		lg.setColor(255,255,255);
		lg.draw(a.n[1],X,math.floor(Y));
		lg.draw(a.n[2],X+x,math.floor(Y+y));
		lg.draw(a.n[3],X+(x*1.5),math.floor(Y+(y*1.5)));
	end
	return a;
end;

function fogo(max,life)
	local a={}
	for i=1,max do
		table.insert(a,{x=0,y=0,h=math.random(20,50),l=0})
	end
	function a:up(v)
		
	end;
	function a:draw(X,Y)
		for i,k in ipairs(self) do
			if not pause then
				k.l=k.l-math.random(3)
				if k.l<=0 then
					k.x=math.random(X);
					k.y=Y-k.h;
					k.l=life;
				else
					k.y=k.y+2;
				end
			end
			lg.setColor(0,0,0,150);
			lg.rectangle("fill",k.x,k.y,2,k.h);
		end
	end
	return a;
end;
