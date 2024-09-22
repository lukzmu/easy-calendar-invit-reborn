WO 					= {}
L  					= {}

-- -----------------------------------------------------------------------------

WO.colors 			= {}
WO.colors.white 	= 'ffffff'
WO.colors.yellow 	= 'ffbb00'
WO.colors.red 		= 'e60000'
WO.colors.green 	= '00ffb7'
WO.colors.sgren 	= '1ced6b'
WO.colors.pink 		= 'ff00e1'
WO.colors.blue 		= '00d5ff'
WO.colors.magenta 	= 'c054ff'
WO.colors.grey 		= '666666'

WO.colors.tanks 	= '6283b3'
WO.colors.heals 	= '3aba9d'
WO.colors.melees 	= 'd10200'
WO.colors.ranges 	= '13e393'
WO.colors.notcmm 	= '555555'

WO.points   		= " ....................................................................................................................................."

WO.isDEBUG 			= false
WO.FAKE 			= false
WO.LOAD  			= false
WO.PRINT 			= "|cffffffffWC ::|r "
WO.Class 			= {}

WO.player			= {}
WO.player.lvl   	= UnitLevel("player") or ''
WO.player.name,WO.player.realm = UnitFullName("player") or ''
WO.player.faction,_ = UnitFactionGroup("player") or ''
WO.player.InGuild 	= false

-- -----------------------------------------------------------------------------
-- ✔︎ FONTS
-- -----------------------------------------------------------------------------

WO.fonts 			= {}

local GameFontTTL 	= "GameFontNormal"      local _,GameFontTTL_Height,_ = GameFontNormal:GetFont()
local GameFontTXT 	= "GameFontNormalSmall" local _,GameFontTXT_Height,_ = GameFontNormalSmall:GetFont()

WO.fonts.TTL_F 		= GameFontTTL
WO.fonts.TTL 		= GameFontTTL_Height
WO.fonts.TTL_02 	= WO.fonts.TTL* .2
WO.fonts.TTL_05 	= WO.fonts.TTL* .5
WO.fonts.TTL_07 	= WO.fonts.TTL* .7
WO.fonts.TTL_12 	= WO.fonts.TTL*1.2
WO.fonts.TTL_14 	= WO.fonts.TTL*1.4
WO.fonts.TTL_15 	= WO.fonts.TTL*1.5
WO.fonts.TTL_16 	= WO.fonts.TTL*1.6
WO.fonts.TTL_18 	= WO.fonts.TTL*1.8
WO.fonts.TTL_20 	= WO.fonts.TTL*2
WO.fonts.TTL_22 	= WO.fonts.TTL*2.2

WO.fonts.TXT_F  	= GameFontTXT
WO.fonts.TXT    	= GameFontTXT_Height
WO.fonts.TXT_02 	= WO.fonts.TXT* .2
WO.fonts.TXT_05 	= WO.fonts.TXT* .5
WO.fonts.TXT_07 	= WO.fonts.TXT* .7
WO.fonts.TXT_12 	= WO.fonts.TXT*1.2
WO.fonts.TXT_14 	= WO.fonts.TXT*1.4
WO.fonts.TXT_15 	= WO.fonts.TXT*1.5
WO.fonts.TXT_16 	= WO.fonts.TXT*1.6
WO.fonts.TXT_18 	= WO.fonts.TXT*1.8
WO.fonts.TXT_20 	= WO.fonts.TXT*2
WO.fonts.TXT_22 	= WO.fonts.TXT*2.2

-- -----------------------------------------------------------------------------
-- ✔︎ SIZES
-- -----------------------------------------------------------------------------

WO.sizes = {}

WO.sizes.PANNEL 	= 444
WO.sizes.MARGES 	= WO.fonts.TXT_07
WO.sizes.MMARGS 	= WO.sizes.MARGES/2

-- -----------------------------------------------------------------------------

WO.sizes.title_h 	= WO.fonts.TTL_14
WO.sizes.lines_h 	= WO.fonts.TXT_14

-- -----------------------------------------------------------------------------
-- ✔︎ Debug Functions
-- -----------------------------------------------------------------------------

function WO:DEBUG(what,more,bug)  if not WO.isDEBUG then return end
	local colors = {['VAR']      = WO.colors.yellow,
					['CALL']     = WO.colors.magenta,
					['REGISTER'] = WO.colors.red,
					['FIRE']     = WO.colors.green,
					['OPTIONS']  = WO.colors.blue,
					['TABLE']    = WO.colors.pink }
	local color = (colors[what] or WO.colors.yellow)
	if more == nil then more = what end
	if type(more) == "table" then
		WO:DEBUG_T(what,more)
	else
		local res = (WO.PRINT.."|cff"..color..(more and tostring(more) or '> ').."|r"..(bug and ' '..tostring(bug) or ''))
		if DLAPI then DLAPI.DebugLog('_DebugLog', res) else print(res) end
	end
end
function WO:DEBUG_T(name,tabl) 		if not WO.isDEBUG then return end
	for k,v in pairs(tabl) do
		WO:DEBUG('TABLE',name," |cff"..WO.colors.magenta..k.." |r "..tostring(v))
		if type(v) == "table" then
			for x,y in pairs(v) do
				WO:DEBUG('TABLE',name," |cff"..WO.colors.magenta..k.." -> "..x.." |r "..tostring(y))
			end
		end
	end
end

-- -----------------------------------------------------------------------------
-- ✔︎ Stuff
-- -----------------------------------------------------------------------------

function WO:HEX(c)
	c = math.floor(c * 255)
	local hex = string.format("%x", c)
	if (hex:len() == 1) then return "0"..hex; end
	return hex;
end
function WO:TRIM(s)
	if not s then return '' end
	return s:gsub('[ \t]+%f[\r\n%z]', '')
	-- return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end
function WO:CLEAN(s)
	if not s then return '' end
	return s:lower():gsub('%W','')
end
function WO:SPAIRS(t, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end
	if order then table.sort(keys, function(a,b) return order(t, a, b) end)
			 else table.sort(keys) end
	local i = 0
	return function()
		i = i + 1
		if keys[i] then return keys[i], t[keys[i]] end
	end
end
function WO:STRIP(str)
	local tableAccents = {}
		--  tableAccents["À"] = "A" --  tableAccents["Á"] = "A" --  tableAccents["Â"] = "A" --  tableAccents["Ã"] = "A" --  tableAccents["Ä"] = "A"
		--  tableAccents["Å"] = "A" --  tableAccents["Æ"] = "AE" --  tableAccents["Ç"] = "C" --  tableAccents["È"] = "E" --  tableAccents["É"] = "E"
		--  tableAccents["Ê"] = "E" --  tableAccents["Ë"] = "E" --  tableAccents["Ì"] = "I" --  tableAccents["Í"] = "I" --  tableAccents["Î"] = "I"
		--  tableAccents["Ï"] = "I" --  tableAccents["Ð"] = "D" --  tableAccents["Ñ"] = "N" --  tableAccents["Ò"] = "O" --  tableAccents["Ó"] = "O"
		--  tableAccents["Ô"] = "O" --  tableAccents["Õ"] = "O" --  tableAccents["Ö"] = "O" --  tableAccents["Ø"] = "O" --  tableAccents["Ù"] = "U"
		--  tableAccents["Ú"] = "U" --  tableAccents["Û"] = "U" --  tableAccents["Ü"] = "U" --  tableAccents["Ý"] = "Y" --  tableAccents["Þ"] = "P"
		tableAccents["ß"] = "s" tableAccents["à"] = "a" tableAccents["á"] = "a" tableAccents["â"] = "a" tableAccents["ã"] = "a"
		tableAccents["ä"] = "a" tableAccents["å"] = "a" tableAccents["æ"] = "ae" tableAccents["ç"] = "c" tableAccents["è"] = "e"
		tableAccents["é"] = "e" tableAccents["ê"] = "e" tableAccents["ë"] = "e" tableAccents["ì"] = "i" tableAccents["í"] = "i"
		tableAccents["î"] = "i" tableAccents["ï"] = "i" tableAccents["ð"] = "eth"
		tableAccents["ñ"] = "n" tableAccents["ò"] = "o" tableAccents["ó"] = "o" tableAccents["ô"] = "o"
		tableAccents["õ"] = "o" tableAccents["ö"] = "o" tableAccents["ø"] = "o" tableAccents["ù"] = "u" tableAccents["ú"] = "u"
		tableAccents["û"] = "u" tableAccents["ü"] = "u" tableAccents["ý"] = "y" tableAccents["þ"] = "p" tableAccents["ÿ"] = "y"
	return str:gsub("[%z\1-\127\194-\244][\128-\191]*", tableAccents) or ''
end
function WO:RXPESC(str) return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1") end

function WO:COUNT(tab)
	local count = 0
	for _ in pairs(tab) do
		count = count + 1
	end
	return count
end

-- -----------------------------------------------------------------------------
-- ✔︎ Create Frame
-- -----------------------------------------------------------------------------

function WO:FRAM(name,type,where,opt, 	z,x,y,yy,zz,	w,h)
	if w == nil then w = WO.fonts.TXT_14 end
	if h == nil then h = WO.fonts.TXT_14 end
	local obj = name
	local stuff = _G[obj] or CreateFrame(type,obj,where,opt)
	if z then stuff:SetPoint(z,x,y,yy,zz) end
	if w and h then stuff:SetSize(w,h) end
	return stuff
end
function WO:BTTN(name,where, 			z,x,y,yy,zz, 	w,h)
	local btn = WO:FRAM(name,"Button",where,"UIPanelButtonTemplate", z,x,y,yy,zz,w,h)
		  btn:DisableDrawLayer("BACKGROUND")
		  btn:SetNormalTexture('') btn:SetPushedTexture('') btn:SetHighlightTexture('')
		  local font = btn:GetNormalFontObject();
				font:SetTextColor(1,1,1,.6); btn:SetNormalFontObject(font);
		  local font = btn:GetHighlightFontObject();
				font:SetTextColor(1,1,1,1); btn:SetHighlightFontObject(font);
	return btn
end
function WO:FADE(name,where,allpoint,f,w)
	local w = w or "BACKGROUND"
	local f = f or .6
	local obj = name
	local stuff = _G[obj] or where:CreateTexture(obj,w)
	if allpoint then stuff:SetAllPoints(true) end
		  stuff:SetColorTexture(0,0,0,f)
	return stuff
end
function WO:ICON(name,where,ico,		z,x,y,		w,h)
	if w == nil then w = WO.fonts.TXT_14 end
	if h == nil then h = WO.fonts.TXT_14 end
	local obj = name
	local stuff = _G[obj] or where:CreateTexture(obj,"HIGHLIGHT")
	if z then stuff:SetPoint(z,x,y) end
		  stuff:SetSize(w,h)
		  stuff:SetTexture(ico)
	return stuff
end
function WO:FONT(name,where,	z,x,y,yy,zz,	w,h,	font,justifyH)
	if font == nil then font = WO.fonts.TXT_F end
	if justifyH == nil then justifyH = "LEFT" end
	local obj = name
	local stuff = _G[obj] or where:CreateFontString(obj,nil,font)
	if z then stuff:SetPoint(z,x,y,yy,zz) end
	if w and h then stuff:SetSize(w,h) end
		  stuff:SetJustifyH(justifyH)
		  stuff:SetJustifyV("MIDDLE")
		  stuff:SetWordWrap(false)
	return stuff
end

function WO:FIRSTUPP(s)
	if s then
		return s:gsub("^%l", string.upper)
	end
end

-- -----------------------------------------------------------------------------
-- ✔︎ Raider IO
-- -----------------------------------------------------------------------------

function WO:SHOW_RIO(tooltip,fullname,realmName,playerFaction)
	if not RaiderIO or not fullname then return end
	local FACTIONS = { Alliance = 1, Horde = 2, Neutral = 3 }
	local playerFactionID = FACTIONS[playerFaction or WO.player.faction]
	RaiderIO.ShowProfile(tooltip,fullname, realmName, playerFactionID);
end
function WO:COLOR_RIO(currentScore)
	if not RaiderIO then return '' end
	local r, g, b = RaiderIO.GetScoreColor(currentScore);
	local hex = WO:HEX(r)..WO:HEX(g)..WO:HEX(b);
	return "|cff"..hex..currentScore.." |r ";
end
function WO:GET_SCORE(fullname,realmName,playerFaction)
	if not RaiderIO or WO.FAKE then return '' end

	local FACTIONS = { Alliance = 1, Horde = 2, Neutral = 3 }
	local playerFactionID = FACTIONS[playerFaction or WO.player.faction]
	local playerProfile = RaiderIO.GetProfile(fullname, realmName, playerFactionID);
	local currentScore = '';
	local previousScore = '';

	if playerProfile == nil then return '' end

	if playerProfile.mythicKeystoneProfile ~= nil then
		currentScore = playerProfile.mythicKeystoneProfile.currentScore or '';
		-- previousScore = playerProfile.mythicKeystoneProfile.previousScore or 0;
	end

	if currentScore == '' or currentScore == 0 then return '' end
	return WO:COLOR_RIO(currentScore)

	--[[ local data = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unit)
	local seasonScore = data and data.currentSeasonScore

	if seasonScore then
		local color = C_ChallengeMode_GetDungeonScoreRarityColor(seasonScore)
		local hex = WO:HEX(color.r)..WO:HEX(color.g)..WO:HEX(color.b);
		return "|cff"..hex..seasonScore.." |r ";
	end ]]

end
function WO:GET_COLOR(className)
	local clname = (className and className ~= '') and WO.Class[className]
	    if RAID_CLASS_COLORS[className] then  return RAID_CLASS_COLORS[className]
	elseif RAID_CLASS_COLORS[clname]    then return RAID_CLASS_COLORS[clname]
	else return { r=.6, g=.6, b=.6, colorStr = 'FFAAAAAA' } end
end

-- -----------------------------------------------------------------------------
-- GET STATES
-- -----------------------------------------------------------------------------

function WO:GET_GUILD()
	WO:DEBUG('VAR','GET_GUILD')
	WO.player.InGuild = IsInGuild()
	if WO.player.InGuild then
		local guild, _, _ = GetGuildInfo("player");
		WO_ez_DBC.guild = guild
	end
	WO.player.name,WO.player.realm = UnitFullName("player")
	WO.player.faction,_ = UnitFactionGroup("player")
	WO.player.lvl   	= UnitLevel("player")

	WO:DEBUG('GET_GUILD',WO.player)
	if WO.player.realm then for x,y in pairs(WO_ez_DB.pvate_roles) do
		if not x:lower():find('-') then
			WO_ez_DB.pvate_roles[x..'-'..WO.player.realm] = y
			WO_ez_DB.pvate_roles[x] = nil
		end
	end end
end