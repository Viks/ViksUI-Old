local T, Viks, L, _ = unpack(select(2, ...))
local blank = {bgFile="interface\\buttons\\white8x8"}
local index = GetCurrentResolution()
local resolution = select(index, GetScreenResolutions())
local x,y = strsplit("x", resolution)
local linesR = {}
local linesL = {}
local linesT = {}
local linesB = {}
r1 = CreateFrame("Frame","wAlignY",UIParent)
r1:SetBackdrop(blank)
r1:SetBackdropColor(1,0,0,1)
r1:SetSize(2,y)
r1:SetPoint("CENTER",UIParent)
table.insert(linesR,r1)
table.insert(linesL,r1)
local r2 = CreateFrame("Frame","wAlignX",r1)
r2:SetBackdrop(blank)
r2:SetBackdropColor(1,0,0,1)
r2:SetSize(x,2)
r2:SetPoint("CENTER",UIParent)
table.insert(linesT,r2)
table.insert(linesB,r2)
r1:Hide()
function lineUpdate(space,x,y)
	local numLinesX = (x/space)
	for i = 1,numLinesX do
		if not (linesR[i]) then
			local lR = r1:CreateTexture(nil,"OVERLAY")
			lR:SetSize(1,y)
			lR:SetTexture(0,0,0,0.5)
			lR:SetPoint("LEFT",linesR[i-1],"RIGHT",space,0)
			table.insert(linesR, lR)
		else
			if (i~=1) then
				linesR[i]:SetPoint("LEFT",linesR[i-1],"RIGHT",space,0)
			end
		end
		if not (linesL[i]) then
			local lL = r1:CreateTexture(nil,"OVERLAY")
			lL:SetSize(1,y)
			lL:SetTexture(0,0,0,0.5)
			lL:SetPoint("RIGHT",linesL[i-1],"LEFT",-space,0)
			table.insert(linesL, lL)
		else
			if (i~=1) then
				linesL[i]:SetPoint("RIGHT",linesL[i-1],"LEFT",-space,0)
			end
		end
	end
	local numLinesY = (y/space)
	for j = 1,numLinesY do
		if not (linesT[j]) then
			local lT = r2:CreateTexture(nil,"OVERLAY")
			lT:SetSize(x,1)
			lT:SetTexture(0,0,0,0.5)
			lT:SetPoint("BOTTOM",linesT[j-1],"TOP",0,space)
			table.insert(linesT, lT)
		else
			if (j~=1) then
				linesT[j]:SetPoint("BOTTOM",linesT[j-1],"TOP",0,space)
			end
		end
		if not (linesB[j]) then
			local lB = r2:CreateTexture(nil,"OVERLAY")
			lB:SetSize(x,1)
			lB:SetTexture(0,0,0,0.5)
			lB:SetPoint("TOP",linesB[j-1],"BOTTOM",0,-space)
			table.insert(linesB, lB)
		else
			if (j~=1) then
				linesB[j]:SetPoint("TOP",linesB[j-1],"BOTTOM",0,-space)
			end
		end
	end
end
lineUpdate(20,x,y)
SLASH_WALIGN1 = '/walign'
SLASH_WALIGN2 = '/align'
SLASH_WALIGN3 = '/wal'
function SlashCmdList.WALIGN(msg, editbox)
	if (msg) and (type(tonumber(msg))=="number") then
		if (tonumber(msg)<=4) then 
			print("|cffe1a500w|cff69ccf0Align|r: Please enter a number at least 5 or larger.")
		else
			if not (r1:IsShown()) then
				r1:Show()
			end
			lineUpdate(msg,x,y)
		end
	else
		if not(r1:IsShown()) then
			r1:Show()
		else
			r1:Hide()
		end
	end
end