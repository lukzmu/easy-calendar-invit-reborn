-- -----------------------------------------------------------------------------

WO.isAnchorTo = false
WO.eInfo      = false
WO.isOpen     = false
WO.canEdit    = false

WO.MinResizW  = 170
WO.MaxResizW  = 444

WO.play_txt_maxwidth = 0
WO.play_lvl_maxwidth = 0

WO.sizes.PANNELINFOS_H = WO.fonts.TXT_22
WO.sizes.PANNELPRGSS_H = WO.fonts.TXT_22+WO.sizes.MARGES+WO.sizes.MARGES
WO.sizes.PANNELONLYC_H = WO.fonts.TXT_22

WO.sizes.ICNSUM        = WO.fonts.TTL*1

WO.sizes.play_txt      = WO.fonts.TTL*7
WO.sizes.play_lvl      = WO.fonts.TTL*7

WO.FOLDR      = "Interface\\AddOns\\WO_ezcalinvit\\medias\\"

-- -----------------------------------------------------------------------------

WO.eInfo      = false
WO.canEdit    = false
WO.isOpen     = false
WO.InPrgrss   = false
WO.toPrgrss   = false
WO.lastUpdat  = 0

WO.invites    = {}
WO.toRemove   = {}
WO.toInvite   = {}
WO.toProcess  = 0

-- -----------------------------------------------------------------------------

WO.all_ranks  		= {}
WO.all_communities 	= {}

WO.all_guildiz		= {}
WO.all_private		= {}
WO.all_commplr		= {}
WO.all_pickups		= {}

WO.all_roles  		= {}
WO.Class      		= {}

WO.name_grp   = "WOEZGroup_"
WO.name_plr   = "WOEZPlayr_"

-- -----------------------------------------------------------------------------
-- ✔︎ Load addon
-- -----------------------------------------------------------------------------

function WO:LOAD() WO:DEBUG('VAR','LOAD')
	if not WO_ez_DB  then WO_ez_DB  = {} end
	if WO_ez_DB.pvate_roles		== nil then WO_ez_DB.pvate_roles   = {}				end
	if WO_ez_DB.pvate_roster	== nil then WO_ez_DB.pvate_roster  = {}				end
	if WO_ez_DB.all_classes		== nil then WO_ez_DB.all_classes   = {}				end

	if not WO_ez_DBC then WO_ez_DBC = {} end
	if WO_ez_DBC.width 			== nil then WO_ez_DBC.width        = 200			end
	if WO_ez_DBC.guild			== nil then WO_ez_DBC.guild        = ''				end
	if WO_ez_DBC.guildrankGM	== nil then WO_ez_DBC.guildrankGM  = 2				end
	if WO_ez_DBC.pvate_list		== nil then WO_ez_DBC.pvate_list   = true			end
	if WO_ez_DBC.pvate_name		== nil then WO_ez_DBC.pvate_name   = L["PU_List"]	end
	if WO_ez_DBC.pvate_roster	== nil then WO_ez_DBC.pvate_roster = {}				end
	if WO_ez_DBC.pvate_totop	== nil then WO_ez_DBC.pvate_totop  = true			end
	if WO_ez_DBC.commu_totop	== nil then WO_ez_DBC.commu_totop  = false			end
	if WO_ez_DBC.communities	== nil then WO_ez_DBC.communities  = {}				end
	if WO_ez_DBC.enable_green	== nil then WO_ez_DBC.enable_green = true			end
	if WO_ez_DBC.enable_icons	== nil then WO_ez_DBC.enable_icons = true			end
	if WO_ez_DBC.enable_icnof	== nil then WO_ez_DBC.enable_icnof = false			end
	if WO_ez_DBC.enable_ilevl	== nil then WO_ez_DBC.enable_ilevl = true			end
	if WO_ez_DBC.enable_ilevf	== nil then WO_ez_DBC.enable_ilevf = true			end
	if WO_ez_DBC.enable_lolvl	== nil then WO_ez_DBC.enable_lolvl = false			end
	if WO_ez_DBC.enable_notes	== nil then WO_ez_DBC.enable_notes = true			end
	if WO_ez_DBC.enable_noteo	== nil then WO_ez_DBC.enable_noteo = false			end
	if WO_ez_DBC.only_invited	== nil then WO_ez_DBC.only_invited = false			end
	if WO_ez_DBC.transparencz	== nil then WO_ez_DBC.transparencz = .6 			end

	if WO_ez_DBC.hide_ranks		== nil then
		WO_ez_DBC.hide_ranks	= WO_ez_DBC.guild_ranks and WO_ez_DBC.guild_ranks or {}
		WO_ez_DBC.guild_ranks 	= nil
	end
	if WO_ez_DBC.enable_summa then WO_ez_DBC.enable_summa= nil end
	if WO_ez_DBC.pvate_roles  then WO_ez_DBC.pvate_roles = nil end
	if WO_ez_DBC.viewguilder  then WO_ez_DBC.viewguilder = nil end

	for k, v in pairs(_G.LOCALIZED_CLASS_NAMES_MALE)   do WO.Class[v] = k end
	for k, v in pairs(_G.LOCALIZED_CLASS_NAMES_FEMALE) do WO.Class[v] = k end

	WOF.main:SetWidth(WO_ez_DBC.width) --	WOF.main:SetHeight(WO_ez_DBC.heigh)
	WO:DEBUG('WO_ez_DBC',WO_ez_DBC)

	WOF.main_f 	   = WO:FADE("WOEZmainfade",WOF.main,true,			WO_ez_DBC.transparencz)
	WOF.progress_f = WO:FADE("WOEZprogressfade",WOF.progress,true,	WO_ez_DBC.transparencz*1.4)

	WOF.infos_f    = WO:FADE("WOEZinfosfade",WOF.infos,true,		WO_ez_DBC.transparencz)
	WOF.bottom_f   = WO:FADE("WOEZbottomfade",WOF.bottom,true,		WO_ez_DBC.transparencz)

	WOF.margb_f    = WO:FADE("WOEZmargbfade",WOF.margb,true,		WO_ez_DBC.transparencz)
	WOF.margt_f    = WO:FADE("WOEZmargtfade",WOF.margt,true,		WO_ez_DBC.transparencz)
	WOF.scrollf_f  = WO:FADE("WOEZscrollffade",WOF.scrollf,true,	WO_ez_DBC.transparencz)

	WOF.main:SetResizeBounds(WO.MinResizW, WO.MaxResizW)

	if WO_ez_DBC.only_invited then WOF.bottxt:SetTextColor(1,1,1,1)
	 						  else WOF.bottxt:SetTextColor(.4,.4,.4,1) end

	C_FriendList.ShowFriends()
	C_GuildInfo.GuildRoster()
	WO.LOAD = true
end

function WO:STOPNOW() if WO.player.realm == nil or not WO.LOAD or not WO.isOpen or not WO.eInfo then return true; end end

-- -----------------------------------------------------------------------------
-- ✔︎ GET PLAYERS
-- -----------------------------------------------------------------------------

function WO:GET_GUILD_PLAYERS() if WO:STOPNOW() then return end WO:DEBUG('VAR','GET_GUILD_TABLE')
	wipe(WO.all_ranks)
	wipe(WO.all_guildiz)

	if WO.player.InGuild then
		local totalMembers = GetNumGuildMembers()
		for i = 1, totalMembers do
			local name, rank, rankIndex, level, class, _, note, officernote, isOnline, status, classFileName, _, _, isMobile, _, _, guid = GetGuildRosterInfo(i)
			if not name then return end -- WO:DEBUG('name',name.." - "..status )
			local fname = WO:SET_F(name)
			WO.all_guildiz[fname] = WO:SET_P(fname,rank,rankIndex == 0 and WO_ez_DBC.guildrankGM or rankIndex+1,class,level,note,officernote,isOnline,status)
		end
		for i=2, GuildControlGetNumRanks() do
			WO.all_ranks[i] = GuildControlGetRankName(i)
		end
	end
end

function WO:GET_PRIVATE_PLAYERS() if WO:STOPNOW() then return end WO:DEBUG('VAR','GET_PRIVATE_PLAYERS')
	wipe(WO.all_private)
	local PUs = WO_ez_DBC.pvate_list and WO_ez_DB.pvate_roster or WO_ez_DBC.pvate_roster
	for idp,privna in pairs(PUs) do
		local name,level,note,rankIndex = strsplit(",",privna)
		if not name then return end
		local fname = WO:SET_F(name)
		if WO:GET_P(fname) == false then WO.all_private[fname] = WO:SET_P(fname,'',rankIndex or 0,'',level,note,note,false,'') end
	end
end

function WO:GET_COMMUNITIES() if WO:STOPNOW() then return end WO:DEBUG('VAR','GET_COMMUNITIES')
	wipe(WO.all_communities)
	wipe(WO.all_commplr)

	for clubId,_ in pairs(WO_ez_DBC.communities) do
		local info = C_Club.GetClubInfo(clubId)
		if info then
			WO.all_communities[clubId] = info
			membersInCommunity = C_Club.GetClubMembers(clubId)

			for k,memberID in pairs(membersInCommunity) do
				c = C_Club.GetMemberInfo(clubId, memberID)
				if c.name then
					local onlin = c.presence == 1 and true or nil
					local ismob = c.presence == 2 and true or nil
					local state = c.presence == 4 and 1 or (c.presence == 5 and 2 or 0)
					local class,_,_ = GetClassInfo(c.classID)
					local fname = WO:SET_F(c.name)
					if WO:GET_P(fname) == false then WO.all_commplr[fname] = WO:SET_P(fname,info,clubId,class,c.level,c.memberNote,c.officerNote,onlin,state,ismob) end
				end
			end
		else
			WO_ez_DBC.communities[clubId] = nil
		end
	end
end

function WO:GET_INVITED()	if WO:STOPNOW() then return end WO:DEBUG('CALL','GET_INVITED')
	wipe(WO.invites) local T,H,M,R, Comming,NoReply,NotCmmg,WatCmmg = 0,0,0,0, 0,0,0,0
	wipe(WO.all_pickups)
	local NumInv = C_Calendar.GetNumInvites()
	for i = 1, NumInv do
		local inv = C_Calendar.EventGetInvite(i)
		if inv.name and inv.name ~= nil then
			local class,_,_ = GetClassInfo(inv.classID)
			local fname = WO:SET_F(inv.name)
			    if WO.all_guildiz[fname] then -- already in guild -> nothing
			elseif WO.all_commplr[fname] then -- already in commu -> nothing
			elseif WO.all_private[fname] then -- private roster -> get class
				if WO_ez_DB.all_classes[fname] ~= class then
					WO_ez_DB.all_classes[fname] = class
					WO.all_private[fname].class = class
					WO.all_private[fname].color = WO:GET_COLOR(class)
				end
			else WO.all_pickups[fname] = WO:SET_P(fname,'',0,class,inv.level,note,note,false,'') end
			WO.invites[fname] = inv.inviteStatus

			    if inv.inviteStatus==0 then NoReply=NoReply+1 -- CALENDAR_INVITESTATUS_INVITED
			elseif inv.inviteStatus==7 then NoReply=NoReply+1 -- CALENDAR_INVITESTATUS_NOT_SIGNEDUP

			elseif inv.inviteStatus==1 then Comming=Comming+1 -- CALENDAR_INVITESTATUS_ACCEPTED
			elseif inv.inviteStatus==3 then Comming=Comming+1 -- CALENDAR_INVITESTATUS_CONFIRMED
			elseif inv.inviteStatus==6 then Comming=Comming+1 -- CALENDAR_INVITESTATUS_SIGNEDUP

			elseif inv.inviteStatus==5 then WatCmmg=WatCmmg+1 -- CALENDAR_INVITESTATUS_STANDBY
			elseif inv.inviteStatus==8 then WatCmmg=WatCmmg+1 -- CALENDAR_INVITESTATUS_TENTATIVE

			elseif inv.inviteStatus==2 then NotCmmg=NotCmmg+1 -- CALENDAR_INVITESTATUS_DECLINED
			elseif inv.inviteStatus==4 then NotCmmg=NotCmmg+1 end -- CALENDAR_INVITESTATUS_OUT

			if inv.inviteStatus==1 or inv.inviteStatus==3 or inv.inviteStatus==6 then
			-- CALENDAR_INVITESTATUS_ACCEPTED  CALENDAR_INVITESTATUS_CONFIRMED  CALENDAR_INVITESTATUS_SIGNEDUP
				local role = WO:GROLE(fname)
					if role == "T" then T=T+1
				elseif role == "H" then H=H+1
				elseif role == "M" then M=M+1
				elseif role == "R" then R=R+1 end
			end
		end
	end

	NoReply = (WatCmmg > 0 and ''..NoReply.."+|cff"..WO.colors.white..WatCmmg or NoReply)
	WOF.infos_NCmmg_t:SetText(format('|cff'..WO.colors.red    ..'%s',NotCmmg)) -- not comming
	WOF.infos_NRply_t:SetText(format('|cff'..WO.colors.grey   ..'%s',NoReply)) -- no reply
	WOF.infos_Commg_t:SetText(format('|cff'..(WO_ez_DBC.enable_green and WO.colors.sgren or WO.colors.yellow)..'%s',Comming)) -- comming
	WOF.infos_Commg_i:SetTexture(WO.FOLDR .."st_ok"..(WO_ez_DBC.enable_green and "k" or "")..".tga") -- comming
	WOF.infos_Invit_t:SetText(format('|cff'..WO.colors.white  ..'%s '..L["INVITS"],NumInv)) -- invits
	-- resume
	WOF.sum_rangs_t:SetText(format('|cff'..WO.colors.ranges..'%s',R))
	WOF.sum_meles_t:SetText(format('|cff'..WO.colors.melees..'%s',M))
	WOF.sum_heals_t:SetText(format('|cff'..WO.colors.heals.. '%s',H))
	WOF.sum_tanks_t:SetText(format('|cff'..WO.colors.tanks.. '%s',T))
	WO:DEBUG('WO.invites',WO.invites)
end

-- -----------------------------------------------------------------------------

function WO:SET_F(name)
	local n,r = strsplit( "-", name, 2)
	local s = r or WO.player.realm
	return WO:FIRSTUPP(n)..'-'..WO:FIRSTUPP(s)
end
function WO:SET_P(fname,rankname,rankid,class,level,note,officernote,isOnline,status,mob)
	local name,server = strsplit( "-", fname, 2)
	if not class or class == '' and WO_ez_DB.all_classes[fname] then class = WO_ez_DB.all_classes[fname] end
	WO:READROLES(fname,officernote,note)
	return { name  		= name,
			 fullname  	= fname,
			 class  	= class,
			 color  	= WO:GET_COLOR(class),
			 realm  	= server,
			 rankid  	= rankid or 0,
			 rankname  	= rankname,
			 level 		= tonumber(level),
			 note  		= note,
			 officernote = officernote,
			 isOnline 	= isOnline,
			 state 		= WO:PRESENCE(name,status,isOnline,mob) }
end
function WO:GET_P(name)
	    if WO.all_guildiz[name] then return WO.all_guildiz[name]
	elseif WO.all_private[name] then return WO.all_private[name]
	elseif WO.all_commplr[name] then return WO.all_commplr[name]
	elseif WO.all_pickups[name] then return WO.all_pickups[name]
	else return false end
end

function WO:READROLES(fullname,officer,note)
	local role   = "E"
	local noteto = WO_ez_DBC.enable_icnof and officer or note
	if noteto then
			if noteto:lower():find('tank')
			or noteto:lower():find('tnk')  then role = "T"
		elseif noteto:lower():find('heal') then role = "H"
		elseif noteto:lower():find('dps')
			or noteto:lower():find('melee')
			or noteto:lower():find('cac')  then role = "M"
		elseif noteto:lower():find('range')
			or noteto:lower():find('rng')
			or noteto:lower():find('dist') then role = "R"
		end
	end
	WO.all_roles[fullname] = role
end

function WO:PRESENCE(name,sta,onl,mob)
	if UnitInParty(name) or UnitInRaid(name) then return 'grp'
							   	  elseif mob then return 'mob'
							 elseif sta == 1 then return 'afk'
							 elseif sta == 2 then return 'dnd'
								  elseif onl then return 'onl'
											 else return 'off' end
end

function WO:GICON(ico)
	local ext = '.tga'
		if ico==9 then icon = "st_soon" --
	elseif ico==0 then icon = "st_wait" -- CALENDAR_INVITESTATUS_INVITED
	elseif ico==7 then icon = "st_wait" -- CALENDAR_INVITESTATUS_NOT_SIGNEDUP

	elseif ico==1 then icon = "st_ok"..(WO_ez_DBC.enable_green and "k" or "") -- CALENDAR_INVITESTATUS_ACCEPTED
	elseif ico==3 then icon = "st_ok"..(WO_ez_DBC.enable_green and "k" or "") -- CALENDAR_INVITESTATUS_CONFIRMED
	elseif ico==6 then icon = "st_ok"..(WO_ez_DBC.enable_green and "k" or "") -- CALENDAR_INVITESTATUS_SIGNEDUP

	elseif ico==5 then icon = "st_dunno" -- CALENDAR_INVITESTATUS_STANDBY
	elseif ico==8 then icon = "st_dunno" -- CALENDAR_INVITESTATUS_TENTATIVE

	elseif ico==2 then icon = "st_no" -- CALENDAR_INVITESTATUS_DECLINED
	elseif ico==4 then icon = "st_no" -- CALENDAR_INVITESTATUS_OUT

	elseif ico==10 then icon = "square"
	elseif ico==11 then icon = "square-f"
	end return WO.FOLDR..icon..ext
end

function WO:GROLE(x)
	return WO_ez_DB.pvate_roles[x] and WO_ez_DB.pvate_roles[x] or (WO.all_roles[x] and WO.all_roles[x] or 'E')
end

-- -----------------------------------------------------------------------------
-- ✔︎ DETAILS VIEW
-- -----------------------------------------------------------------------------

function WO:SET_PLAYER(p)		if WO:STOPNOW() then return end
	local x = WO.name_plr..p.fullname
	local play,play_txt,play_tt,play_bg,play_full,play_icn,play_levl,play_lvl,play_nte,play_bbl,play_rol,play_rbt
		  = _G[x],_G[x.."_txt"],_G[x.."_tt"],_G[x.."_bg"],_G[x.."_full"],_G[x.."_icn"],_G[x.."_levl"],_G[x.."_lvl"],_G[x.."_note"],_G[x.."_conn"],_G[x.."_role"],_G[x.."_rbtn"]

	if not play then -- WO:DEBUG('FIRE','create play '..p.fullname)
		play = WO:FRAM(x,"CheckButton",WOF.child,"ChatConfigCheckButtonTemplate",nil,nil,nil,nil,nil,WO.fonts.TXT_14,WO.fonts.TXT_14)

		play:DisableDrawLayer("BACKGROUND")
		play:SetNormalTexture('')
		play:SetPushedTexture('')
		play:SetHighlightTexture('')
		play:SetCheckedTexture('')
		play:SetDisabledCheckedTexture('')

		play_txt = WO:FONT(x.."_txt",play,"LEFT",play,"RIGHT",WO.sizes.MMARGS,0)
		play_txt:SetPoint("RIGHT",WOF.txtwidth, "RIGHT")

		play_icn = WO:ICON(x.."_icn",play,nil,nil,nil,nil,WO.sizes.ICNSUM,WO.sizes.ICNSUM)
		play_icn:SetPoint("LEFT",play,"LEFT",2,0)

		play_lvl = WO:FONT(x.."_lvl",play,"LEFT",play_txt,"RIGHT",0,0,nil,nil, WO.fonts.TXT_F ,"RIGHT")
		play_lvl:SetPoint("RIGHT",WOF.txtlevel,"RIGHT")
		play_lvl:SetTextColor(1,1,1,.7)

		play_nte = WO:FONT(x.."_note",play,"LEFT",play_lvl,"RIGHT",WO.sizes.MMARGS,0, nil,nil,WO.fonts.TXT_F ,"LEFT")
		play_nte:SetTextColor(1,1,1,.4)

		play_bbl = WO:ICON(x.."_conn",play,WO.FOLDR.."round.tga", nil,nil,nil,WO.fonts.TXT_12,WO.fonts.TXT_12 )
		play_bbl:SetVertexColor(1,1,1,.1)

		play_rol = WO:ICON(x.."_role",play,nil,"RIGHT",play_bbl,"LEFT") -- ,WO.fonts.TXT_12,WO.fonts.TXT_12)

		play_rbt = WO:FRAM(x.."_rbtn","Button",play,"UIPanelButtonTemplate")
		play_rbt:SetPoint("TOPRIGHT",  play_rol,"TOPRIGHT",0,2)
		play_rbt:SetPoint("BOTTOMLEFT",play_rol,"BOTTOMLEFT",0,-2)
		play_rbt:SetScript("OnClick", function()
			local oldrole = WO:GROLE(p.fullname)
			local newrole = nil
				if oldrole == "E" then newrole = "M"
			elseif oldrole == "M" then newrole = "R"
			elseif oldrole == "R" then newrole = "H"
			elseif oldrole == "H" then newrole = "T"
			elseif oldrole == "T" then newrole = "E" end

			if newrole == WO.all_roles[p.fullname] then
				  WO_ez_DB.pvate_roles[p.fullname] = nil
			else  WO_ez_DB.pvate_roles[p.fullname] = newrole end
			WO:SET_CALENDARLIST()
			WO:GET_INVITED()
		end)
		play_rbt:SetAlpha(0)
		play_rbt:SetFrameStrata("MEDIUM")

		play_full = WO:FONT(x.."_full",play) play_full:Hide()
		play_levl = WO:FONT(x.."_levl",play) play_levl:Hide()

		play_tt = WO:FRAM(x.."_tt","Button",play,nil,"LEFT",play,"LEFT",0,0)
		play_tt:SetPoint("RIGHT",WOF.scrollf,"RIGHT",-WO.sizes.MMARGS,0) play_tt:SetHeight(WO.sizes.lines_h)

		play_bg = WO:FADE(x.."_bg",play_tt,true,0,"ARTWORK")
		play_bg:SetAlpha(0)
	end

	WO:SET_PLAYER_GROUP(p)
	WO:SET_PLAYER_COLOR(p)
	WO:SET_PLAYER_TEXT(p)
	WO:SET_PLAYER_ROLE(p)
	WO:SET_PLAYER_PRESENCE(p)

	if WO_ez_DBC.enable_icons then
			play_rol:Show() 	play_rbt:Show()
			play_nte:SetPoint("RIGHT",WOF.scrollf,  "RIGHT",-(WO.sizes.MARGES*2.5+WO.fonts.TXT_12),0)
			play_bbl:SetPoint("RIGHT",play_nte,		"RIGHT",(WO.sizes.MARGES*1.7)+WO.fonts.TXT_12,0)

	else 	play_rol:Hide() 	play_rbt:Hide()
			play_nte:SetPoint("RIGHT",WOF.scrollf,  "RIGHT",-(WO.sizes.MARGES*2.5),0)
			play_bbl:SetPoint("RIGHT",play_nte,		"RIGHT",(WO.sizes.MARGES*1.7),0)
  	end
	play_tt:SetScript("OnEnter", function()
		local isenab = play:IsEnabled()
		play_bg:SetAlpha(.15)
		if isenab then play_icn:SetAlpha(.8) end
		play_nte:SetTextColor(p.color.r,p.color.g,p.color.b,1)
		WO:SET_TOOLTIP(false,p)
	end)
	play_tt:SetScript("OnLeave", function()
		play_bg:SetAlpha(0)
		play_nte:SetTextColor(1,1,1,.4)
		WO:SET_TOOLTIP(true ,p)
		if not WO.toInvite[p.fullname] and not WO.toRemove[p.fullname] and not WO.invites[p.fullname] then play_icn:SetAlpha(.25) end
	end)
	play_tt:SetScript("OnClick", function(self, button)
		if WO.canEdit then
			local isenab = play:IsEnabled()
			if play:GetChecked() then
				play_icn:SetTexture(WO:GICON(9))
				WO:DEBUG('REGISTER','remove ',p.fullname)
				play:SetChecked(false)
				WO:INVIT(p.fullname,false)
			elseif isenab then
				play_icn:SetTexture(WO:GICON(9))
				WO:DEBUG('REGISTER','add ',p.fullname)
				play:SetChecked(true)
				WO:INVIT(p.fullname,true)
			end
		end
	end)
end
function WO:SET_PLAYER_GROUP(p)
	local x= WO.name_plr..p.fullname
	local parent = _G[WO.name_grp..p.rankid] and WO.name_grp..p.rankid or WO.name_grp..'0'
	if WO_ez_DBC.only_invited then
		parent = WO.name_grp..WO:GROLE(p.fullname)
	end
	if _G[x] then _G[x]:SetParent(_G[parent]) end
end
function WO:SET_PLAYER_ROLE(p)
	local x= WO.name_plr..p.fullname.."_role"
	local role = WO:GROLE(p.fullname)
	if _G[x] then _G[x]:SetTexture(WO.FOLDR..role..".tga") end
end
function WO:SET_PLAYER_COLOR(p)
	local x= WO.name_plr..p.fullname.."_txt"
	if _G[x] then _G[x]:SetTextColor(p.color.r,p.color.g,p.color.b,1) end
	local y= WO.name_plr..p.fullname.."_bg"
	if _G[y] then _G[y]:SetColorTexture(p.color.r,p.color.g,p.color.b,1) end
end
function WO:SET_PLAYER_TEXT(p)
	local x= WO.name_plr..p.fullname
	if _G[x] then
		_G[x.."_full"]:SetText(p.fullname)
		_G[x.."_txt"] :SetText(p.name)
		_G[x.."_lvl" ]:SetText(WO_ez_DBC.enable_ilevl and p.level or '')
		_G[x.."_levl"]:SetText(p.level or 0)

		local note = WO_ez_DBC.enable_noteo and p.officernote or p.note
		_G[x.."_note"]:SetText(WO_ez_DBC.enable_notes and note  or '')

		if not WO_ez_DBC.enable_ilevl then WOF.txtlevel:SetWidth(WO.sizes.ICNSUM-WO.sizes.MMARGS) else
		local play_lvl_w = _G[x.."_lvl"]:GetStringWidth()+WO.sizes.ICNSUM if WOF.txtlevel:GetWidth() < play_lvl_w then WOF.txtlevel:SetWidth(play_lvl_w) end end
		local play_txt_w = _G[x.."_txt"]:GetStringWidth(); 				  if WOF.txtwidth:GetWidth() < play_txt_w then WOF.txtwidth:SetWidth(play_txt_w) end
	end
end
function WO:SET_PLAYER_PRESENCE(p)
	local x= WO.name_plr..p.fullname.."_conn"
	if _G[x] then
		if p.state == 'grp' then _G[x]:SetVertexColor( 0,.6,.9, 1)
	elseif p.state == 'mob' then _G[x]:SetVertexColor(.8,.4, 0,.4)
	elseif p.state == 'afk' then _G[x]:SetVertexColor(.8,.4, 0, 1)
	elseif p.state == 'dnd' then _G[x]:SetVertexColor( 1, 0, 0, 1)
	elseif p.state == 'onl' then _G[x]:SetVertexColor( 0,.9,.2, 1)
	-- elseif p.state == 'out' then _G[x]:SetVertexColor( 1, 1, 1,.1)
						 	else _G[x]:SetVertexColor( 1, 1, 1,.1) end
	end
end

function WO:SET_TOOLTIP(hide,p,x) if WO:STOPNOW() then GameTooltip:Hide() return end
	if hide then GameTooltip:Hide() --------------------------------------------
	else -----------------------------------------------------------------------
		GameTooltip:SetOwner(_G[WO.name_plr..p.fullname], "ANCHOR_BOTTOMRIGHT",WO_ez_DBC.width-WO.sizes.MARGES,WO.sizes.PANNELINFOS_H*2);
		GameTooltip:AddDoubleLine(p.name,p.realm,p.color.r,p.color.g,p.color.b,.6,.6,.6);
		GameTooltip:AddDoubleLine((p.class and p.class ~= '') and p.class or '- ',p.level,p.color.r,p.color.g,p.color.b,p.color.r,p.color.g,p.color.b);

		GameTooltip:AddLine('\n')
		if p.note and p.note ~= '' then
			GameTooltip:AddLine(p.note  ,1,1,1, true)
			GameTooltip:AddTexture(131129, {anchor=0,vertexColor={r=p.color.r,g=p.color.g,b=p.color.b,a=1},margin={right=2} })
		end
		if p.officernote and p.officernote ~= '' and p.officernote ~= p.note then
			GameTooltip:AddLine(p.officernote,.6,.6,.6, true)
			GameTooltip:AddTexture(131129, {anchor=0,vertexColor={r=1,g=1,b=1,a=.6},margin={right=2} })
		end
		GameTooltip:AddLine('\n')

		GameTooltip:Show()
		WO:SHOW_RIO(GameTooltip,p.name,p.realm)
	end ------------------------------------------------------------------------
end

-- -----------------------------------------------------------------------------
-- ✔︎ GROUPS
-- -----------------------------------------------------------------------------

function WO:SET_GROUP(id,groupName)	if WO:STOPNOW() then return end
	local x = WO.name_grp..id
	local group,group_txt,group_btn,group_icn = _G[x],_G[x.."_txt"],_G[x.."_btn"],_G[x.."_icn"]

	if not group then -- WO:DEBUG('REGISTER','create group '..groupName..' / '..WO.name_grp..id)
		group = WO:FRAM(x,"CheckButton",WOF.child,"ChatConfigCheckButtonTemplate",nil,nil,nil,nil,nil,	WO.fonts.TXT_14,WO.fonts.TXT_14)


		group_txt = WO:FONT(x.."_txt",group,"LEFT",group,"RIGHT",WO.sizes.MMARGS,0, nil,nil,WO.fonts.TTL_F,"LEFT")
		group_txt:SetPoint("RIGHT",WOF.scrollf, "RIGHT",-(WO.sizes.MARGES),0)

		group_btn = WO:FRAM(x.."_btn","Button",group,"UIPanelButtonTemplate") group_btn:SetAlpha(0) group_btn:SetFrameStrata("HIGH")
		group_btn:SetPoint("RIGHT",WOF.scrollf,"RIGHT",-(WO.sizes.MARGES),0)
		group_btn:SetPoint("LEFT" ,group      ,"RIGHT",  WO.sizes.MARGES ,0)

		if id == 'T' or id == 'H' or id == 'M' or id == 'R' or id == 'E' then
			group_txt:SetTextColor(1,1,1,1)
			group_txt:SetPoint("LEFT",group,"LEFT",WO.sizes.MMARGS,0)
		else
			group_icn = WO:ICON(x.."_icn",group,nil,nil,nil,nil,WO.sizes.ICNSUM,WO.sizes.ICNSUM)
			group_icn:SetPoint("LEFT",group,"LEFT",2,0)
			group_icn:SetAlpha(.25)
			group_icn:SetVertexColor(1,1,1)
			group_txt:SetTextColor(1,1,1,.7)
			group_btn:SetScript("OnEnter", function() group_txt:SetTextColor(1,1,1, 1) end)
			group_btn:SetScript("OnLeave", function() group_txt:SetTextColor(1,1,1,.7) end)
		end
	end
	group_txt:SetText(string.upper(groupName).." "..WO.points..WO.points..WO.points..WO.points)
	group_btn:SetText(id)

	group:SetNormalTexture('')
	group:SetPushedTexture('')
	group:SetHighlightTexture('')
	group:SetCheckedTexture('')
	group:SetDisabledCheckedTexture('')

	if id == 'T' or id == 'H' or id == 'M' or id == 'R' or id == 'E' then
	else
		group:SetScript("OnEnter", function() group_icn:SetAlpha( .8) end)
		group:SetScript("OnLeave", function() group_icn:SetAlpha(.25) end)
		group_btn:SetScript("OnClick", function()
			if WO_ez_DBC.hide_ranks[id] then WO_ez_DBC.hide_ranks[id] = nil
										else WO_ez_DBC.hide_ranks[id] = true end WO:POSITIONS()
		end)
	end
	return group
end

-- -----------------------------------------------------------------------------
-- ✔︎ CALENDAR ACTIONS
-- -----------------------------------------------------------------------------

function WO:CLOSE_PANNEL()
	WO:DEBUG('CALL','CLOSE_PANNEL')
	WO.eInfo   = false
	WO.isOpen  = false
	WO.canEdit = false
	WO:PROGRESS_STOP()
	WOF.main:Hide()
	WOF.main:ClearAllPoints()
end

function WO:OPEN_PANNEL()
	WO:DEBUG('CALL','OPEN_PANNEL')
	WO:GET_EVENT()

	if not WO.player.realm or WO.player.realm == '' then WO:GET_GUILD() end
	if WO:STOPNOW() then return end

	WO:PROGRESS_STOP()
	WOF.main:ClearAllPoints()
	local margin = (ElvUI and 0 or 3)
	if WO.canEdit then
		WOF.main:SetPoint(   "TOPLEFT",CalendarCreateEventFrame,   "TOPRIGHT",32, 0-margin)
		WOF.main:SetPoint("BOTTOMLEFT",CalendarCreateEventFrame,"BOTTOMRIGHT",32, 0+margin)
	else
		WOF.main:SetPoint(   "TOPLEFT",CalendarViewEventFrame,   "TOPRIGHT",32, 0-margin)
		WOF.main:SetPoint("BOTTOMLEFT",CalendarViewEventFrame,"BOTTOMRIGHT",32, 0+margin)
	end
	WOF.main:Show()

	WOF.main:SetResizeBounds(WO.MinResizW, WO.MinResizW, GetScreenHeight()*3/4, WOF.main:GetHeight())
	if WO_ez_DBC.only_invited then
			WOF.bottnc:SetChecked(true)  WOF.bottxt:SetTextColor(1,1,1,1)
	else    WOF.bottnc:SetChecked(false) WOF.bottxt:SetTextColor(.4,.4,.4,1) end

	WO:SET_CALENDARLIST(true)
end

function WO:GET_EVENT()
	WO.eInfo   = false
	WO.isOpen  = false
	WO.canEdit = false
	WO.eInfo = C_Calendar.GetEventInfo() -- WO:DEBUG('WO.eInfo',WO.eInfo)
	if WO.eInfo then
		WO.isOpen = true
		WO.canEdit = C_Calendar.EventCanEdit()
	end
end
function WO:PROGRESS(msg)
	WOF.progress_t:SetText(msg or L["UPDATING..."])
	WOF.progress:Show()
end

function WO:PROGRESS_STOP() WO:DEBUG('REGISTER','PROGRESS_STOP ??')
	WO.toProcess,WO.InPrgrss,WO.toPrgrss = 0, false,false
	wipe(WO.toRemove)
	wipe(WO.toInvite)
	WOF.progress:Hide()
end

function WO:INVIT(who,add) 		  if WO:STOPNOW() then return end
	if WO.player.name == who then return end
	if add then
		if WO.eInfo.calendarType == "GUILD_EVENT" and WO.all_guildiz[who] then
			WO.toInvite[who] = nil
		else
			WO.toInvite[who] = true
			WO.toRemove[who] = nil
			WO.toProcess = WO.toProcess +1
		end
	else
		WO.toInvite[who] = nil
		WO.toRemove[who] = true
		WO.toProcess = WO.toProcess +1
	end
	WO:PROGRESS()
end
function WO:INVITS(tablewho,add)  if WO:STOPNOW() then return end
	WO:DEBUG('who',tablewho)
	for who,_ in pairs(tablewho) do WO:INVIT(who,add) end
end

function WO:CLEAN_INVITS()

	WO:DEBUG('--------')
	WO:DEBUG('invites',WO.invites)
	WO:DEBUG('---')
	WO:DEBUG('toInvite',WO.toInvite)
	WO:DEBUG('---')
	WO:DEBUG('toRemove',WO.toRemove)
	WO:DEBUG('--------')
	WO.toInvite[WO.player.name..'-'..WO.player.realm] = nil
	WO.toRemove[WO.player.name..'-'..WO.player.realm] = nil
	for k,_ in pairs(WO.toInvite) do if     WO.invites[k] then WO.toInvite[k]=nil end end
	for k,_ in pairs(WO.toRemove) do if not WO.invites[k] then WO.toRemove[k]=nil end end

	WO.toProcess = WO:COUNT(WO.toInvite)+WO:COUNT(WO.toRemove)
end

function WO:DO_INVITS()			  if WO:STOPNOW() then return end WO:DEBUG('REGISTER','DO_INVITS',WO.toProcess)
	if WO.canEdit and WO.toProcess > 0 then
		WO:GET_INVITED()
		WO:CLEAN_INVITS()
		WO:DEBUG('REGISTER','toProcess ->', WO.toProcess)
		local howManyLeft = WO.toProcess..L[" LEFT..."]

		if WO.toProcess == 0 then
			WO:PROGRESS(L["... Done !"])
			WO:PROGRESS_STOP()
		else
			---------------------------------------------------------- to invite
			local nextone, _ = next(WO.toInvite)
			if nextone ~= nil and not WO.InPrgrss then
				if WO.eInfo.isLocked then
					WO:PROGRESS("|cff"..datas.colors.red..L["locked..."].." [ "..WO.eInfo.title.." ] ")
					wipe(WO.toInvite)
					wipe(WO.toRemove)
					return
				else
					WO:PROGRESS(howManyLeft.." |cff"..WO.colors.yellow..L["ADDING "]..nextone)
					WO.InPrgrss = true
					-- WO.pToInvi_p[nextone] = true
					C_Calendar.EventInvite(nextone)
				end
			else
				------------------------------------------------------ to remove
				local nextone, _ = next(WO.toRemove)
				if nextone ~= nil then
					WO:PROGRESS(howManyLeft.." |cff"..WO.colors.yellow..L["REMOVING "]..nextone)
					local NumInv = C_Calendar.GetNumInvites()
					for i = 1, NumInv do
						local inviteData = C_Calendar.EventGetInvite(i)
						if nextone == inviteData.name or nextone == inviteData.name..'-'..WO.player.realm then
							C_Calendar.EventRemoveInvite(i)
							break
						end
					end
				end
				----------------------------------------------------- end invite
			end
		end
		WO:GET_INVITED()
		WO:SET_CALENDARLIST()
	else
		-- WO:PROGRESS_STOP()
		WO:GET_INVITED()
		WO:SET_CALENDARLIST()
	end
end


-- -----------------------------------------------------------------------------
-- ✔︎ ROSTER VIEW
-- -----------------------------------------------------------------------------

function WO:POSITIONS()			if WO:STOPNOW() then return end	WO:DEBUG('CALL','POSITIONS ??')
	local r_top = -WO.sizes.MMARGS
	local all_groups = { WOF.child:GetChildren() }
	for _, group in ipairs(all_groups) do group:Hide() end

	if WO_ez_DBC.only_invited then
		r_top = WO:POSITIONS_GRP(WO.name_grp..'T',r_top)
		r_top = WO:POSITIONS_GRP(WO.name_grp..'H',r_top)
		r_top = WO:POSITIONS_GRP(WO.name_grp..'M',r_top)
		r_top = WO:POSITIONS_GRP(WO.name_grp..'R',r_top)
		r_top = WO:POSITIONS_GRP(WO.name_grp..'E',r_top)
	else
			if     WO_ez_DBC.pvate_totop then r_top = WO:POSITIONS_GRP(WO.name_grp..'0',r_top) end -- PRIVATE LISTE
	for k, n in pairs(WO.all_ranks)  	  do  r_top = WO:POSITIONS_GRP(WO.name_grp..k  ,r_top) end -- GUILDE
	for k, n in pairs(WO.all_communities) do  r_top = WO:POSITIONS_GRP(WO.name_grp..k  ,r_top) end -- COMMUNITIES
			if not WO_ez_DBC.pvate_totop then r_top = WO:POSITIONS_GRP(WO.name_grp..'0',r_top) end -- PRIVATE LISTE

	end
	r_top = math.abs(r_top)
	local ScrollHeight = WOF.scrollf:GetHeight()
	local MaxScroll = r_top-ScrollHeight
	WOF.scrollb:SetMinMaxValues(0,MaxScroll>0 and MaxScroll or 1)
	-- if WO.toProcess == 0 then WO:PROGRESS_STOP() end
end

function WO:POSITIONS_GRP(name,r_top)
	local group = _G[name]
	if group and group:GetObjectType() == "CheckButton" then
		group:SetPoint("TOPLEFT",WO.sizes.MMARGS,r_top)
		local idG = _G[name.."_btn"]:GetText()
		local rnk_hide = WO_ez_DBC.hide_ranks[tonumber(idG)] and true or false
		local players = { group:GetChildren() }
		local nb_playerin,nb_playerck,toadd = 0,0,{}
		local enable = true
		if not WO.canEdit or WO.eInfo.isLocked then enable = false end

		for _, player in ipairs(players) do
			if player:GetObjectType() == "CheckButton" then
				local x = player:GetName()
				local n = gsub(x,WO.name_plr,'')
				------
				if WO:GET_P(n) then
					local showp = true
					local ison  = true
					if WO.canEdit and not WO.eInfo.isLocked then
						if WO.eInfo.calendarType == "GUILD_EVENT" and WO.all_guildiz[n] then
							 player:Disable() ison = false
						else player:Enable()  toadd[n] = true end
					else
						player:Disable() ison = false
					end

					if WO_ez_DBC.only_invited then ---------------- only invited
						if WO.invites[n] or WO.toInvite[n] or WO.toRemove[n] then
							player:SetAlpha((WO.invites[n]==2 or WO.invites[n]==4 or WO.invites[n]==7) and 1 or .4)
						else
							showp = false
						end
					else -------------------------------------------------------
						if WO_ez_DBC.enable_lolvl then
							local levl = _G[x.."_levl"] and _G[x.."_levl"]:GetText() or 0
							showp = (tonumber(levl) >= WO.player.lvl) and true or false
						else
							local levl = _G[x.."_levl"] and _G[x.."_levl"]:GetText() or 0
							if WO_ez_DBC.enable_ilevf then player:SetAlpha(tonumber(levl) < WO.player.lvl and .4 or 1) else player:SetAlpha(1) end
						end

					end --------------------------------------------------------
					if showp then ----------------------------------------------

						if not WO.toRemove[n] and (WO.invites[n] or WO.toInvite[n]) then nb_playerck = nb_playerck +1 end
						nb_playerin = nb_playerin +1

						if rnk_hide then player:Hide() else --------------------
							if WO.toInvite[n] or WO.toRemove[n] then _G[x.."_icn"]:SetAlpha(1) _G[x.."_icn"]:SetTexture(WO:GICON(9))
										   elseif WO.invites[n] then _G[x.."_icn"]:SetAlpha(1) _G[x.."_icn"]:SetTexture(WO:GICON(WO.invites[n]))
																else _G[x.."_icn"]:SetAlpha(.2)
															if ison then _G[x.."_icn"]:SetTexture(WO:GICON(10))
																	else _G[x.."_icn"]:SetTexture(WO:GICON(11)) end
																end

							    if WO.toRemove[n] then player:SetChecked(false)
							elseif WO.invites[n] or WO.toInvite[n] then player:SetChecked(true)
							else player:SetChecked(false) end


							r_top = r_top - WO.sizes.lines_h
							player:SetPoint("TOPLEFT",WOF.child, "TOPLEFT",WO.sizes.MMARGS,r_top)
							player:Show()

						end
					else
						player:Hide()
					end --------------------------------------------------------
					------------------------------------------------------------
				else
					player:Hide()
				end
			end
		end
		if nb_playerin == 0 then
			group:Hide()
		else
			group:Show()
			group:SetAlpha(rnk_hide and .4 or 1)
			if WO:COUNT(toadd) == 0 then enable = false end

			if enable then  if _G[name.."_icn"] then _G[name.."_icn"]:SetTexture(WO:GICON(10)) end group:Enable()
					  else  if _G[name.."_icn"] then _G[name.."_icn"]:SetTexture(WO:GICON(11)) end group:Disable() end

			if nb_playerin == nb_playerck and _G[name.."_icn"] then _G[name.."_icn"]:SetTexture(WO:GICON(1)) end

			group:SetChecked(nb_playerin == nb_playerck and true or false)

			group:SetScript("OnClick", function(self, button)
				WO:DEBUG('toaddsss',toadd) -- self:Disable()
				if self:GetChecked() then
					WO:INVITS(toadd,true)
					local players = { group:GetChildren() }
					for _, player in ipairs(players) do if player:GetObjectType() == "CheckButton" then local isenab = player:IsEnabled(); if isenab then player:SetChecked(true)  end end end
				else
					WO:INVITS(toadd,false)
					local players = { group:GetChildren() }
					for _, player in ipairs(players) do if player:GetObjectType() == "CheckButton" then local isenab = player:IsEnabled(); if isenab then player:SetChecked(false) end end end
				end
			end)
			r_top = r_top - WO.sizes.title_h
		end
	end
	return r_top;
end

function WO:SET_CALENDARLIST(x)	if WO:STOPNOW() then return end	WO:DEBUG('CALL','---> SET_CALENDARLIST ', x)
	if x then
		WO:GET_GUILD_PLAYERS()
		WO:GET_PRIVATE_PLAYERS()
		WO:GET_COMMUNITIES()
		WO:GET_INVITED()
	end
	WO:SET_GROUP(0,WO_ez_DBC.pvate_name)
	WO:SET_GROUP('T','TANKS')
	WO:SET_GROUP('H','HEALS')
	WO:SET_GROUP('M','MELEES')
	WO:SET_GROUP('R','RANGES')
	WO:SET_GROUP('E',WO.points..WO.points..WO.points..WO.points)

	--------------------------------------------------------------------- GROUPS
	for k, n in pairs(WO.all_ranks)  	  do local rank = WO:SET_GROUP(k,n) 	 end
	for k, n in pairs(WO.all_communities) do local rank = WO:SET_GROUP(k,n.name) end

	-------------------------------------------------------------------- PLAYERS
	for k, n in pairs(WO.all_guildiz) 	  do local play = WO:SET_PLAYER(n) end
	for k, n in pairs(WO.all_private) 	  do local play = WO:SET_PLAYER(n) end
	for k, n in pairs(WO.all_commplr) 	  do local play = WO:SET_PLAYER(n) end
	for k, n in pairs(WO.all_pickups) 	  do local play = WO:SET_PLAYER(n) end

	----------------------------------------------------------------------------
	WO:POSITIONS()
end

-- -----------------------------------------------------------------------------
