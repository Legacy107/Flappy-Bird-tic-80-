-- title:  Flappy Bird tic edition
-- author: Legacy 107
-- desc:   A clone of flappy bird
-- script: lua

function init()
t=0
score=0
bird={
     x=84,
     y=60,
					mpx=84,
					mpy=24
     }
vy=0
jy=0
menu=true
over=false
mx=0
imap=0
done=false
done2=false 
f=0
end
highscore=0
savescore=0
abs=math.abs
init()    --set up--
highscore=pmem(savescore)
version="1.1.7"
cheat=true

function check(x,y)
   return mget(x//8,y//8)
end

function createcollumn()
   local collumn={}
			      dem=0
			--lower section--
   for k=1,9 do
			   dem=k
			   if k==9 then collumn[k]=2 break end
			   collumn[k]=math.random(0,4)
						if collumn[k]==2 or
						   collumn[k]==3 or
								 collumn[k]==4 then collumn[k]=1 end
						if collumn[k]==0
						then collumn[k]=2 break  end
			end
			--upper section--
			collumn[dem+7]=3
			for h=dem+8,16 do
			   collumn[h]=1 end
			return collumn
end

function drawcollumn(mapind,icollumn,j)
local c=0
      if icollumn==nil then c=47 end
			   if icollumn==1 then c=180 end
						if icollumn==2 then c=164 end
					 if icollumn==3 then c=168 end
			   mset(mapind+33,j,c)
						mset(mapind+34,j,c+1)
						mset(mapind+35,j,c+2)
end

function mainmenu()
   if btnp(4,0,100) then 
			   menu=false vy=-3 end
   map(imap,0,35,17,mx,0)
   for l=0,5 do 
	  spr(384+l*2,l*18+22,10,0,1,0,0,2,2) end
			for l=0,3 do 
	  spr(416+l*2,l*18+144,10,0,1,0,0,2,2) end
			print("TIC edition",90,30,6)
			spr(1+f%30//15*2,bird.x,bird.y,0,1,0,0,2,2)
			spr(5+f%60//30,156,60,0,2)
			print("--Press   ".."   to fly--",115,66)
			print("v"..version,205,120)
   f=f+1	
end
		
function TIC()
local collumns={}
 if menu==true then mainmenu() else
 cls(13)
	--create collumns--
	if imap%10==0 and done==false then 
	   done=true
	   collumns={}
	   collumns=createcollumn() 
				for k=1,16 do 
				drawcollumn(imap,collumns[k],16-k)end  
				done=true
	end
	--check score--
	if (imap-5)%10==0 and done2==false and t>40 then 
	   done2=true
				if imap>20 then score=score+1 end
	end
	
 if cheat==true then
	--cheat--
	if btnp(6,0,100) then 
	over=false vy=vy-1 jy=0 end
	if btn(2) then mx=mx+1 end
	if btn(3) then mx=mx-1 end
	end
	
 map(imap,0,35,17,mx,0)
 
	vy=vy+0.2
	if check(bird.mpx+1,bird.mpy+15+vy)>129
	or check(bird.mpx+16,bird.mpy+15+vy)>129
	   then vy=0 over=true end
	if over==false then
 if check(bird.mpx,bird.mpy-2)>129 
	or check(bird.mpx+16,bird.mpy+1)>129
	   then over=true end
	end
	--fly--
	if over==false then
	  if btnp(4,0,100) then vy=0 vy=vy-2.5 sfx(1,"B-4") end
 end
	
	if over==true and jy==0 then 
	   sfx(0,"B-2") jy=1 end
				
	bird.y=vy+bird.y
	bird.mpy=bird.y
	spr(1+t%30//15*2,bird.x,bird.y,0,1,0,0,2,2)
	if bird.y<-5 then over=true end
	t=t+1
	if over==false then mx=mx-1 bird.mpx=bird.mpx+1 end
	if abs(mx%16)==0 then mx=-8 imap=imap+1 done=false done2=false end
	if imap==240 then imap=0 bird.mpx=90 end
	spr(54,180,1,0,1.5,0,0,2,2)
	spr(56,196,1,0,1.5,0,0,2,2)
	spr(57,212,1,0,1.5,0,0,2,2)
	print("score",183,6,0)
	print(score,215,6,0)
	
	if over==true then
	   if highscore<score then
				   highscore=score 
							pmem(savescore,highscore) end
	   if btnp(5,10,100)then init()end
				print("High score "..pmem(savescore),90,5,6)
				spr(7+t%60//30,101,100,0,2)
			 print("--Press   ".."   to return--",60,106,0)
	end			
	end
end