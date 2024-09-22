-- -----------------------------------------------------------------------------
--[[----------------------------------------------------------------------------

                     _    ,- WOEZ CALENDAR INVIT
                   /✷_)      Made with ❤ by woOtzee
           _.---._/ /
         /         /
      _/         |/
     /__.-|_|--|_|
                                     Feel free to contact me / hello@wootzee.com
-- -------------------------------------------------------------------------]]--
-- -----------------------------------------------------------------------------

if not C_AddOns.IsAddOnLoaded("Blizzard_Calendar") then UIParentLoadAddOn("Blizzard_Calendar") end

-- -----------------------------------------------------------------------------
-- ✔︎ EVENTS
-- -----------------------------------------------------------------------------

local eventss = { "ADDON_LOADED",

    "PLAYER_GUILD_UPDATE",
    "GUILD_ROSTER_UPDATE",
    "GROUP_ROSTER_UPDATE",

    "CALENDAR_OPEN_EVENT",
    "CALENDAR_CLOSE_EVENT",

    "CALENDAR_UPDATE_ERROR",
    "CALENDAR_UPDATE_ERROR_WITH_COUNT",
    "CALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME",

    "CALENDAR_UPDATE_EVENT",
    "CALENDAR_UPDATE_EVENT_LIST",

	"CALENDAR_ACTION_PENDING",

    "CLUB_ADDED",
    "CLUB_REMOVED",
    "CLUB_MEMBER_ADDED",
    "CLUB_MEMBER_REMOVED",
    "CLUB_MEMBER_PRESENCE_UPDATED" }

 --   "CALENDAR_UPDATE_INVITE_LIST",

for _,event in pairs(eventss) do --[[ WO:DEBUG('REGISTER',event);  ]] WOF.main:RegisterEvent(event); end


WOF.main:SetScript("OnEvent",function(self,event,...)
    local arg = ...
    WO:DEBUG('FIRE',event,tostring(arg))
    ----------------------------------------------------------------------------
    if event == "ADDON_LOADED" and arg == "WO_ezcalinvit" then
        WO:LOAD()
        WOF.main:UnregisterEvent("ADDON_LOADED")
    ----------------------------------------------------------------------------
    elseif 	event == "PLAYER_GUILD_UPDATE" then -- This appears to be fired when a player is gkicked, gquits, etc. // PLAYER_GUILD_UPDATE: unitTarget
        WO:GET_GUILD()
		WO:SET_CALENDARLIST()
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    elseif event == "CALENDAR_OPEN_EVENT" then
        if arg == "PLAYER" or arg == "GUILD_EVENT" or arg=="COMMUNITY_EVENT" then WO:OPEN_PANNEL()
        																	 else WO:CLOSE_PANNEL() end
    ----------------------------------------------------------------------------
    elseif event == "CALENDAR_CLOSE_EVENT"  then WO:CLOSE_PANNEL()
	elseif event == "CALENDAR_UPDATE_EVENT" then WO:GET_EVENT()
	----------------------------------------------------------------------------
	elseif event == "CALENDAR_UPDATE_EVENT_LIST" then
		C_Timer.After(1, function()
			WO:GET_INVITED()
			WO:SET_CALENDARLIST()
		end)
	elseif event == "CALENDAR_ACTION_PENDING" then
		if arg == false then
			WO:GET_INVITED()
			WO:SET_CALENDARLIST()
			if WO.InPrgrss then WO.toPrgrss = true end
		else
			WO.toPrgrss = false
			WO.InPrgrss = true
		end

   	 --	------------------------------------------------------------------------
    elseif event == "CALENDAR_UPDATE_ERROR" then
        if arg == "CALENDAR_ERROR_EVENT_PASSED" or arg == "CALENDAR_ERROR_NO_COMMUNITY_INVITES" or arg == "CALENDAR_ERROR_NO_GUILD_INVITES" or arg == "CALENDAR_ERROR_INVITES_DISABLED" then WO:PROGRESS_STOP() end
		WO:GET_INVITED()
		WO:SET_CALENDARLIST()
    ----------------------------------------------------------------------------
    elseif event == "CALENDAR_UPDATE_ERROR_WITH_COUNT" then
        WO:PROGRESS_STOP()
		WO:GET_INVITED()
		WO:SET_CALENDARLIST()
    ----------------------------------------------------------------------------
    elseif event == "CALENDAR_UPDATE_ERROR_WITH_COUNT" then
        WO:PROGRESS_STOP()
		WO:GET_INVITED()
		WO:SET_CALENDARLIST()
    ----------------------------------------------------------------------------
    else -----------------------------------------------------------------------

        if WO:STOPNOW() then return
        --	--------------------------------------------------------------------
        elseif 	event == "GROUP_ROSTER_UPDATE" then
			WO:SET_CALENDARLIST()
        --	--------------------------------------------------------------------
        elseif 	event == "GUILD_ROSTER_UPDATE" then
            WO:GET_GUILD_PLAYERS()
			WO:SET_CALENDARLIST()
        --	--------------------------------------------------------------------
        elseif 	event == "CLUB_ADDED" or event == "CLUB_REMOVED" or event == "CLUB_MEMBER_ADDED" or event == "CLUB_MEMBER_REMOVED" or
                event == "CLUB_MEMBER_PRESENCE_UPDATED" then -- CLUB_MEMBER_PRESENCE_UPDATED: clubId, memberId, presence
            WO:GET_COMMUNITIES()
			WO:SET_CALENDARLIST()
        ------------------------------------------------------------------------

		-- elseif event == "CALENDAR_ACTION_PENDING" then
		-- 	if arg == true then WO.canDoStuff = false
		-- 		   		   else WO.canDoStuff = true  end
		-- 	return
        ------------------------------------------------------------------------
        end

    ----------------------------------------------------------------------------
    end
end)

-- -----------------------------------------------------------------------------
-- ✔︎ UPDATE
-- -----------------------------------------------------------------------------

WOF.main:SetScript("OnUpdate",function(self,elapsed)
    WO.lastUpdat = WO.lastUpdat + elapsed
    if WO.lastUpdat > 1 then
		if WO.InPrgrss and WO.toPrgrss then
			WO.InPrgrss = false
			WO.toPrgrss = false
		elseif WO.toProcess > 0 and not WO.InPrgrss then
			WO:DO_INVITS()
		end
		WO.lastUpdat = 0
     end
end)

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------