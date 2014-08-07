local T, Viks, L, _ = unpack(select(2, ...))
local _, class = UnitClass("player")
--local r, g, b = CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b		--Classcolor // Use Classcolors Addon Values. 
local r, g, b = unpack(Viks.media.pxcolor1)

pxfont = Viks.media.pxfont 			-- main font in Viks UI
pxfontsize = Viks.media.pxfontsize

DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_TOP"
	local xoff = 0
	local yoff = 4
	return anchor, panel, xoff, yoff
end
--------------------------------------------------------------------
-- TIME
--------------------------------------------------------------------
if Viks.datatext.Wowtime == true then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = CPMinimb2:CreateFontString(nil, "OVERLAY")
	Text:SetFont(pxfont, pxfontsize, "OUTLINE")
	Text:SetHeight(CPMinimb2:GetHeight())
	Text:SetTextColor(r, g, b)
	Text:SetPoint("RIGHT", CPMinimb2,"RIGHT", 0, 1)

	local int = 1
	local function Update(self, t)
		local pendingCalendarInvites = CalendarGetNumPendingInvites()
		int = int - t
		if int < 0 then
			if Viks.datatext.Localtime == true then
				Hr24 = tonumber(date("%H"))
				Hr = tonumber(date("%I"))
				Min = date("%M")
				if Viks.datatext.Time24 == true then
					if pendingCalendarInvites > 0 then
					Text:SetText("|cffFF0000"..Hr24..":"..Min)
				else
					Text:SetText(Hr24..":"..Min)
				end
			else
				if Hr24>=12 then
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffpm|r")
					end
				else
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffam|r")
					end
				end
			end
		else
			local Hr, Min = GetGameTime()
			if Min<10 then Min = "0"..Min end
			if Viks.datatext.Time24 == true then
				if pendingCalendarInvites > 0 then			
					Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffff|r")
				else
					Text:SetText(Hr..":"..Min.." |cffffffff|r")
				end
			else
				if Hr>=12 then
					if Hr>12 then Hr = Hr-12 end
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffpm|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffpm|r")
					end
				else
					if Hr == 0 then Hr = 12 end
					if pendingCalendarInvites > 0 then
						Text:SetText("|cffFF0000"..Hr..":"..Min.." |cffffffffam|r")
					else
						Text:SetText(Hr..":"..Min.." |cffffffffam|r")
					end
				end
			end
		end
		self:SetAllPoints(Text)
		int = 1
		end
	end

	Stat:SetScript("OnEnter", function(self)
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		OnLoad = function(self) RequestRaidInfo() end
		
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		local pvp = GetNumWorldPVPAreas()
		for i=1, pvp do
			local timeleft = select(5, GetWorldPVPAreaInfo(i))
			local name = select(2, GetWorldPVPAreaInfo(i))
			local inprogress = select(3, GetWorldPVPAreaInfo(i))
			local inInstance, instanceType = IsInInstance()
			if not ( instanceType == "none" ) then
				timeleft = QUEUE_TIME_UNAVAILABLE
			elseif inprogress then
				timeleft = WINTERGRASP_IN_PROGRESS
			else
				local hour = tonumber(format("%01.f", floor(timeleft/3600)))
				local min = format(hour>0 and "%02.f" or "%01.f", floor(timeleft/60 - (hour*60)))
				local sec = format("%02.f", floor(timeleft - hour*3600 - min *60)) 
				timeleft = (hour>0 and hour..":" or "")..min..":"..sec
			end
			GameTooltip:AddDoubleLine("Time to".." "..name,timeleft)
		end
		GameTooltip:AddLine(" ")
		
		if( UnitLevel( "player" ) == 90 ) then
		local Sha = IsQuestFlaggedCompleted( 32099 )
		local Galleon = IsQuestFlaggedCompleted( 32098 )
		local Oondasta = IsQuestFlaggedCompleted( 32519 )
		local Nalak = IsQuestFlaggedCompleted( 32518 )
		local Celestrials = IsQuestFlaggedCompleted(33117)
		local Ordos = IsQuestFlaggedCompleted(33118)
		local Seals = IsQuestFlaggedCompleted(33133)
		

		GameTooltip:AddDoubleLine( "Sha Of Anger" .. ": ", Sha and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Galleon" .. ": ", Galleon and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Oondasta" .. ": ", Oondasta and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Nalak" .. ": ", Nalak and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Celestrials" .. ": ", Celestrials and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Ordos" .. ": ", Ordos and "|cff00ff00" .. "Defeated" .. "|r" or "|cffff0000" .. "Undefeated" .. "|r" )
		GameTooltip:AddDoubleLine( "Seals" .. ": ", Seals and "|cff00ff00" .. "Done" .. "|r" or "|cffff0000" .. "Uncompleate" .. "|r" )
		
	end
	
		if Viks.datatext.Localtime == true then
			local Hr, Min = GetGameTime()
			if Min<10 then Min = "0"..Min end
			if Viks.datatext.Time24 == true then         
				GameTooltip:AddDoubleLine("Server Time: ",Hr .. ":" .. Min);
			else             
				if Hr>=12 then
				Hr = Hr-12
				if Hr == 0 then Hr = 12 end
					GameTooltip:AddDoubleLine("Server Time: ",Hr .. ":" .. Min.." PM");
				else
					if Hr == 0 then Hr = 12 end
					GameTooltip:AddDoubleLine("Server Time: ",Hr .. ":" .. Min.." AM");
				end
			end
		else
			Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = date("%M")
			if Viks.datatext.time24 == true then
				GameTooltip:AddDoubleLine("Local Time: ",Hr24 .. ":" .. Min);
			else
				if Hr24>=12 then
					GameTooltip:AddDoubleLine("Local Time: ",Hr .. ":" .. Min.." PM");
				else
					GameTooltip:AddDoubleLine("Local Time: ",Hr .. ":" .. Min.." AM");
				end
			end
		end  
		
		local oneraid
		for i = 1, GetNumSavedInstances() do
			local name,_,reset,difficulty,locked,extended,_,isRaid,maxPlayers = GetSavedInstanceInfo(i)
			if isRaid and (locked or extended) then
				local tr,tg,tb,diff
				if not oneraid then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine("Saved Raid(s)")
					oneraid = true
				end

				local function fmttime(sec,table)
				local table = table or {}
				local d,h,m,s = ChatFrame_TimeBreakDown(floor(sec))
				local string = gsub(gsub(format(" %dd %dh %dm "..((d==0 and h==0) and "%ds" or ""),d,h,m,s)," 0[dhms]"," "),"%s+"," ")
				local string = strtrim(gsub(string, "([dhms])", {d=table.days or "d",h=table.hours or "h",m=table.minutes or "m",s=table.seconds or "s"})," ")
				return strmatch(string,"^%s*$") and "0"..(table.seconds or L"s") or string
			end
			if extended then tr,tg,tb = 0.3,1,0.3 else tr,tg,tb = 1,1,1 end
			if difficulty == 3 or difficulty == 4 then diff = "H" else diff = "N" end
			GameTooltip:AddDoubleLine(name,fmttime(reset),1,1,1,tr,tg,tb)
			end
		end
		GameTooltip:Show()
	end)
	
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnUpdate", Update)
	Stat:RegisterEvent("UPDATE_INSTANCE_INFO")
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == 'RightButton'  then
			ToggleTimeManager()
		else
			GameTimeFrame:Click()
		end
	end)
	Update(Stat, 10)
end