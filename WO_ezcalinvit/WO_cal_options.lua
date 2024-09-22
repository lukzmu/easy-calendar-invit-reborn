-- -----------------------------------------------------------------------------

local Options = CreateFrame("Frame", "WOEZOptions", InterfaceOptionsFramePanelContainer)
	  Options.name = "WOEZ Calendar Invit"
	  Options:Hide()
Settings.RegisterAddOnCategory(Settings.RegisterCanvasLayoutCategory(Options, "WOEZOptions"))

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

Options:SetScript("OnShow", function(self)
	WO:DEBUG('OPTIONS','','OnShow')
	WO:GET_GUILD()

	local Title = self:CreateFontString("WOEZ_OPT_Title", "ARTWORK", "GameFontNormalLarge")
		  Title:SetPoint("TOPLEFT", 16, -16)
		  Title:SetText(self.name)

	local Version = WO:FONT("WOEZ_OPT_Version",self,"TOPLEFT", Title, "BOTTOMLEFT", 0, -5, nil,nil,"GameFontHighlightSmall","LEFT")
		  Version:SetText(L["WO_Easy"])


	function addbtn(name,value,text,textb)

		local line = WO:FRAM("WOEZ_OPT_"..name,"CheckButton",self,"ChatConfigCheckButtonTemplate",nil,nil,nil,nil,nil, WO.fonts.TXT_18, WO.fonts.TXT_18)
		if text == "T" then local line_txt = WO:ICON("WOEZ_OPT_"..name.."_txt",line,WO.FOLDR .."st_okk.tga", "LEFT",line,"RIGHT",WO.fonts.TTL_14,WO.fonts.TTL_14)
		else
		local line_txt = WO:FONT("WOEZ_OPT_"..name.."_txt",line,"LEFT",line,"RIGHT",WO.sizes.MMARGS,0, nil,nil,WO.fonts.TTL_F,"LEFT")
			  line_txt:SetText(text)
			  line_txt:SetTextColor(1,1,1,1)
		end
		if textb then
			local line_bis = WO:FRAM("WOEZ_OPT_"..name.."b","CheckButton",self,"ChatConfigCheckButtonTemplate",nil,nil,nil,nil,nil,WO.fonts.TXT_18,WO.fonts.TXT_18)

			if textb == "T" then local line_txt_bis = WO:ICON("WOEZ_OPT_"..name.."_txtb",line_bis,WO.FOLDR .."st_ok.tga", "LEFT",line_bis,"RIGHT",WO.fonts.TTL_14,WO.fonts.TTL_14)
			else
			local line_txt_bis = WO:FONT("WOEZ_OPT_"..name.."_txtb",line_bis,"LEFT",line_bis,"RIGHT",WO.sizes.MMARGS,0, nil,nil,WO.fonts.TTL_F,"LEFT")
				  line_txt_bis:SetText(textb)
				  line_txt_bis:SetTextColor(1,1,1,1)
			end
			if value == true then line:SetChecked(true) line_bis:SetChecked(false) else line:SetChecked(false) line_bis:SetChecked(true) end
			return line,line_txt,line_bis,line_txt_bis
		else
			if value == true then line:SetChecked(true) else line:SetChecked(false) end
			return line,line_txt
		end
	end


	function self:refresh()
		local HShowRank = -20

		-- ---------------------------------------------------------------------
		-- ---------------------------------------------------------------------

		local InfosZ1 = WO:FONT("WOEZ_OPT_DP",self,"TOPLEFT", Version,"BOTTOMLEFT",0,-17,nil,nil,"GameFontNormal","LEFT")
			  InfosZ1:SetText(L["Display"])
		HShowRank = HShowRank+6

		-- ----------------------------------------------------- ON enable_ilevl

		local line_WOEZ_OPT_NO,line_WOEZ_OPT_NOt = addbtn("NO",WO_ez_DBC.enable_notes,L["Display_Note"])
			  line_WOEZ_OPT_NO:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",66,HShowRank)
			  line_WOEZ_OPT_NO:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_notes = true else WO_ez_DBC.enable_notes = false end WO:SET_CALENDARLIST() end)

		-- ----------------------------------------------------- ON enable_noteo

		local line_WOEZ_OPT_NF,line_WOEZ_OPT_NFt = addbtn("NF",WO_ez_DBC.enable_noteo,L["Officers_Notes"])
			  line_WOEZ_OPT_NF:SetPoint("LEFT",line_WOEZ_OPT_NO,"RIGHT",116,0)
			  line_WOEZ_OPT_NF:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_noteo = true else WO_ez_DBC.enable_noteo = false end WO:SET_CALENDARLIST() end)

		-- ------------------------------------------------------ ON enable_green

		local line_WOEZ_OPT_GRT,line_WOEZ_OPT_GRTt,line_WOEZ_OPT_GRB,line_WOEZ_OPT_GRBt = addbtn("GRT",WO_ez_DBC.enable_green,"T","T")
		line_WOEZ_OPT_GRT:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",516,HShowRank)
		line_WOEZ_OPT_GRB:SetPoint("TOPLEFT",line_WOEZ_OPT_GRT,"TOPLEFT",0,-22)
		line_WOEZ_OPT_GRT:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_green = true  line_WOEZ_OPT_GRB:SetChecked(false) else WO_ez_DBC.enable_green = false line_WOEZ_OPT_GRT:SetChecked(true) end WOF.infos_Commg_i:SetTexture(WO.FOLDR .."st_ok"..(WO_ez_DBC.enable_green and "k" or "")..".tga")  WO:SET_CALENDARLIST() end)
		line_WOEZ_OPT_GRB:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_green = false line_WOEZ_OPT_GRT:SetChecked(false) else WO_ez_DBC.enable_green = true  line_WOEZ_OPT_GRB:SetChecked(true) end WOF.infos_Commg_i:SetTexture(WO.FOLDR .."st_ok"..(WO_ez_DBC.enable_green and "k" or "")..".tga")  WO:SET_CALENDARLIST() end)

		-- ---------------------------------------------------------------------
		HShowRank = HShowRank-22
		-- ---------------------------------------------------------------------

		-- ----------------------------------------------------- ON enable_ilevl

		local line_WOEZ_OPT_IL,line_WOEZ_OPT_ILt = addbtn("IL",WO_ez_DBC.enable_ilevl,L["Display_Level"])
			  line_WOEZ_OPT_IL:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",66,HShowRank)
			  line_WOEZ_OPT_IL:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_ilevl = true else WO_ez_DBC.enable_ilevl = false end WO:SET_CALENDARLIST() end)

		-- ----------------------------------------------------- ON enable_ilevf
		-- ----------------------------------------------------- ON enable_lolvl

		local line_WOEZ_OPT_IF,line_WOEZ_OPT_IFt = addbtn("IF",WO_ez_DBC.enable_ilevf,L["Fade_Level"])
			  line_WOEZ_OPT_IF:SetPoint("LEFT",line_WOEZ_OPT_IL,"RIGHT",116,0)

		local line_WOEZ_OPT_LF,line_WOEZ_OPT_LFt = addbtn("LF",WO_ez_DBC.enable_lolvl,L["Hide_Level"])
			  line_WOEZ_OPT_LF:SetPoint("LEFT",line_WOEZ_OPT_IF,"RIGHT",136,0)

			  line_WOEZ_OPT_LF:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_lolvl = true WO_ez_DBC.enable_ilevf = false line_WOEZ_OPT_IF:SetChecked(false) else WO_ez_DBC.enable_lolvl = false end WO:SET_CALENDARLIST() end)
			  line_WOEZ_OPT_IF:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_ilevf = true WO_ez_DBC.enable_lolvl = false line_WOEZ_OPT_LF:SetChecked(false) else WO_ez_DBC.enable_ilevf = false end WO:SET_CALENDARLIST() end)


		-- ---------------------------------------------------------------------
		HShowRank = HShowRank-40
		-- ---------------------------------------------------------------------

		-- -------------------------------------------------------- Transparency

		local InfosSLID = WO:FONT("WOEZ_OPT_SLID",self,"TOPLEFT", Version,"BOTTOMLEFT",0,HShowRank,nil,nil,"GameFontNormal","LEFT")
			  InfosSLID:SetText(L["BG_alpha"])

		local slider_WOEZ_OPT = WO:FRAM("WOEZ_OPT_transparancy","Slider",self,"OptionsSliderTemplate")
			  slider_WOEZ_OPT:SetPoint("LEFT",InfosSLID,"RIGHT",22,0)
			  slider_WOEZ_OPT:SetWidth(100)
			  slider_WOEZ_OPT:SetHeight(16)
			  slider_WOEZ_OPT:SetMinMaxValues(0,1)
			  slider_WOEZ_OPT:SetValue(WO_ez_DBC.transparencz)
			  slider_WOEZ_OPT:SetValueStep(0.1)
			  slider_WOEZ_OPT:SetOrientation('HORIZONTAL')
 			  getglobal(slider_WOEZ_OPT:GetName() .. 'Low'):SetText('0')
 			  getglobal(slider_WOEZ_OPT:GetName() .. 'High'):SetText('1')
			  slider_WOEZ_OPT:Show()
			  slider_WOEZ_OPT:SetScript("OnValueChanged", function(self)
					WO_ez_DBC.transparencz = self:GetValue()

					WOF.main_f 	   = WO:FADE("WOEZmainfade",WOF.main,true,			WO_ez_DBC.transparencz)
					WOF.progress_f = WO:FADE("WOEZprogressfade",WOF.progress,true,	WO_ez_DBC.transparencz*1.4)

					WOF.infos_f    = WO:FADE("WOEZinfosfade",WOF.infos,true,		WO_ez_DBC.transparencz)
					WOF.bottom_f   = WO:FADE("WOEZbottomfade",WOF.bottom,true,		WO_ez_DBC.transparencz)

					WOF.margb_f    = WO:FADE("WOEZmargbfade",WOF.margb,true,		WO_ez_DBC.transparencz)
					WOF.margt_f    = WO:FADE("WOEZmargtfade",WOF.margt,true,		WO_ez_DBC.transparencz)
					WOF.scrollf_f  = WO:FADE("WOEZscrollffade",WOF.scrollf,true,	WO_ez_DBC.transparencz)
				end)

		-- ---------------------------------------------------------------------
		HShowRank = HShowRank-40
		-- ---------------------------------------------------------------------

		local InfosZ2 = WO:FONT("WOEZ_OPT_RO",self,"TOPLEFT", Version,"BOTTOMLEFT",0,HShowRank+3,nil,nil,"GameFontNormal","LEFT")
			  InfosZ2:SetText(L["Roles"])
		HShowRank = HShowRank+6

		-- ----------------------------------------------------- ON enable_icons

		local line_WOEZ_OPT_IC,line_WOEZ_OPT_ICt = addbtn("IC",WO_ez_DBC.enable_icons,L["Display_Roles"])
			  line_WOEZ_OPT_IC:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",66,HShowRank)
			  line_WOEZ_OPT_IC:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_icons = true else WO_ez_DBC.enable_icons = false end WO:SET_CALENDARLIST() end)

		local line_WOEZ_OPT_IO,line_WOEZ_OPT_IOt = addbtn("IO",WO_ez_DBC.enable_icnof,L["Search_Role_Officer"])
			  line_WOEZ_OPT_IO:SetPoint("LEFT",line_WOEZ_OPT_IC,"RIGHT",116,0)
			  line_WOEZ_OPT_IO:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.enable_icnof = true else WO_ez_DBC.enable_icnof = false end WO:SET_CALENDARLIST() end)

		local enableIC_inf = WO:FONT("WOEZ_OPT_IC_inf",line_WOEZ_OPT_IC,"LEFT",line_WOEZ_OPT_IC,"LEFT",WO.sizes.MMARGS,-20, nil,nil,WO.fonts.TTL_F,"LEFT")
			  enableIC_inf:SetText(L["Details_Roles_L1"])
			  enableIC_inf:SetTextColor(1,1,1,.4)
		local enableIC_inb = WO:FONT("WOEZ_OPT_IC_inb",line_WOEZ_OPT_IC,"LEFT",line_WOEZ_OPT_IC,"LEFT",WO.sizes.MMARGS,-32, nil,nil,WO.fonts.TTL_F,"LEFT")
			  enableIC_inb:SetText(L["Details_Roles_L2"])
			  enableIC_inb:SetTextColor(1,1,1,.4)
		local enableIC_inc = WO:FONT("WOEZ_OPT_IC_inc",line_WOEZ_OPT_IC,"LEFT",line_WOEZ_OPT_IC,"LEFT",WO.sizes.MMARGS,-44, nil,nil,WO.fonts.TTL_F,"LEFT")
			  enableIC_inc:SetText(L["Details_Roles_L3"])
			  enableIC_inc:SetTextColor(1,1,1,.4)

		-- ---------------------------------------------------------------------
		HShowRank = HShowRank-80
		-- ---------------------------------------------------------------------

		local InfosZ3 = WO:FONT("WOEZ_OPT_PP",self,  "TOPLEFT", Version, "BOTTOMLEFT", 0, HShowRank,   nil,nil,"GameFontNormal","LEFT")
			  InfosZ3:SetText(L["PUs_List"])
		HShowRank = HShowRank+4

		-- ---------------------------------------------------------- pvate_name

		local obj = "WOEZ_OPT_namePV"
		local namePV = _G[obj] or CreateFrame("EditBox",obj, self, "InputBoxTemplate")
			  namePV:SetPoint("TOPLEFT", Version, "BOTTOMLEFT",73,HShowRank+2)
			  namePV:SetSize(110, 20)
			  namePV:SetAutoFocus(false)
			  namePV:SetScript("OnKeyUp", function(self) WO_ez_DBC.pvate_name = self:GetText() WO:SET_CALENDARLIST() end)
			  namePV:SetText(WO_ez_DBC.pvate_name)
			  namePV:Show()

		-- ------------------------------------------------------ ON pvate_totop

		local line_WOEZ_OPT_PVT,line_WOEZ_OPT_PVTt,line_WOEZ_OPT_PVB,line_WOEZ_OPT_PVBt = addbtn("PVT",WO_ez_DBC.pvate_totop,L["View_Top"],L["View_Bot"])
			  line_WOEZ_OPT_PVT:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",200,HShowRank)
			  line_WOEZ_OPT_PVB:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",354,HShowRank)

			  line_WOEZ_OPT_PVT:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.pvate_totop = true  line_WOEZ_OPT_PVB:SetChecked(false) else WO_ez_DBC.pvate_totop = false line_WOEZ_OPT_PVB:SetChecked(true) end WO:SET_CALENDARLIST() end)
			  line_WOEZ_OPT_PVB:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.pvate_totop = false line_WOEZ_OPT_PVT:SetChecked(false) else WO_ez_DBC.pvate_totop = true  line_WOEZ_OPT_PVT:SetChecked(true) end WO:SET_CALENDARLIST() end)


		local WOEZ_OPT_PP_inf = WO:FONT("WOEZ_OPT_PP_inf",namePV,"LEFT",namePV,"LEFT",-2,-22, nil,nil,WO.fonts.TTL_F,"LEFT")
			  WOEZ_OPT_PP_inf:SetText(L["Details_PU_L1"])
			  WOEZ_OPT_PP_inf:SetTextColor(1,1,1,.4)

		local WOEZ_OPT_PB_inf = WO:FONT("WOEZ_OPT_PB_inf",namePV,"LEFT",namePV,"LEFT",-2,-50, nil,nil,WO.fonts.TTL_F,"LEFT")
			  WOEZ_OPT_PB_inf:SetText(L["Details_PU_L2"])

		local InfosZ4 = WO:FONT("WOEZ_OPT_CM",namePV,"LEFT",namePV,"LEFT",284,-50, nil,nil,"GameFontNormal","LEFT")
			  InfosZ4:SetText(L["Communities"])

		-- ---------------------------------------------------------------------
		HShowRank = HShowRank-70
		-- ---------------------------------------------------------------------

		-- ------------------------------------------------------ ON pvate_roster

		local ManualBackdrop = { bgFile = "Interface\\ChatFrame\\ChatFrameBackground" }
		local obj = "WOEZ_OPT_lisSF"
		local scroPB = WO:FRAM("WOEZ_OPT_lisSB","ScrollFrame",self,BackdropTemplateMixin and "BackdropTemplate")
			  scroPB:SetSize(244,180)
			  scroPB:SetPoint("TOPLEFT", Version, "BOTTOMLEFT",68,HShowRank-22)
			  scroPB:SetBackdrop(ManualBackdrop)
			  scroPB:SetBackdropColor(0, 0, 0, 0.6)
		local scroPV = WO:FRAM("WOEZ_OPT_lisSF","ScrollFrame",self,"UIPanelScrollFrameTemplate")
			  scroPV:SetSize(240,180)
			  scroPV:SetPoint("TOPLEFT", Version, "BOTTOMLEFT",70,HShowRank-22)

		local listPV = WO:FRAM("WOEZ_OPT_liste","EditBox",scroPV)
			  listPV:SetFontObject(ChatFontNormal)
			  listPV:SetMultiLine(true)
			  listPV:SetWidth(238)
			  listPV:SetAutoFocus(false)
			  listPV:SetCursorPosition(0)
			  listPV:SetJustifyH("LEFT")
			  listPV:SetJustifyV("TOP")
			  listPV:SetTextColor(1,1,1,.6)
			  scroPV:SetScrollChild(listPV)
			  listPV:SetText(table.concat(WO_ez_DBC.pvate_list and WO_ez_DB.pvate_roster or WO_ez_DBC.pvate_roster, "\n")  )
			  listPV:SetScript("OnKeyUp", function(self)
				if WO_ez_DBC.pvate_list then WO_ez_DB.pvate_roster  = { strsplit("\n",self:GetText()) }
										else WO_ez_DBC.pvate_roster = { strsplit("\n",self:GetText()) }  end
				WO:SET_CALENDARLIST(true)
			  end)

		-- ----------------------------------------------------- ON Global liste

		local line_WOEZ_ADD_GL,line_WOEZ_ADD_GLt = addbtn("GL",WO_ez_DBC.pvate_list,L["Details_PU_L5"])
			  line_WOEZ_ADD_GL:SetPoint("TOPLEFT",Version,"BOTTOMLEFT",66,HShowRank)
			  line_WOEZ_ADD_GL:SetScript("OnClick", function(self, button)
				if self:GetChecked() then
					WO_ez_DBC.pvate_list = true
					listPV:SetText(table.concat(WO_ez_DB.pvate_roster, "\n"))
				else
					WO_ez_DBC.pvate_list = false
					listPV:SetText(table.concat(WO_ez_DBC.pvate_roster,"\n"))
				end
				WO:SET_CALENDARLIST(true)
			end)

		-- --------------------------------------------------------------------

		local WOEZ_OPT_PB_inf = WO:FONT("WOEZ_OPT_PC_inf",scroPV,"LEFT",scroPV,"BOTTOMLEFT",0,-12, nil,nil,WO.fonts.TTL_F,"LEFT")
			  WOEZ_OPT_PB_inf:SetText(L["Details_PU_L3"])
			  WOEZ_OPT_PB_inf:SetTextColor(1,1,1,.4)

		local WOEZ_OPT_PB_inb = WO:FONT("WOEZ_OPT_PC_inb",scroPV,"LEFT",scroPV,"BOTTOMLEFT",0,-28, nil,nil,WO.fonts.TTL_F,"LEFT")
			  WOEZ_OPT_PB_inb:SetText(L["Details_PU_L4"])
			  WOEZ_OPT_PB_inb:SetTextColor(1,1,1,.4)

		-- ----------------------------------------------- WO_ez_DBC.communities

		local InfosScrollF = WO:FRAM("WOEZ_OPT_CM_SCRL","ScrollFrame",self,nil,  nil,nil,nil,nil,nil, 220,72)
			  InfosScrollF:SetPoint("TOPLEFT",Version,352,HShowRank-12)

		local InfosScrollb = WO:FRAM("WOEZ_OPT_CM_SCRLb","Slider",InfosScrollF,"UIPanelScrollBarTemplate","TOPRIGHT", InfosScrollF,"TOPRIGHT", -2, -WO.fonts.TXT_14)
			  InfosScrollb:SetPoint("BOTTOMRIGHT", InfosScrollF, "BOTTOMRIGHT",-2,WO.fonts.TXT_14)
			  InfosScrollb:SetMinMaxValues(1, 200)
			  InfosScrollb:SetValueStep(10)
			  InfosScrollb:SetValue(0)
			  InfosScrollb.scrollStep = 10
			  InfosScrollb:SetScript("OnValueChanged",function (self, value) self:GetParent():SetVerticalScroll(value) end)

			  InfosScrollb                  :SetWidth( WO.fonts.TXT_14)
			  InfosScrollb.ThumbTexture     :SetWidth( WO.fonts.TXT_14)
			  InfosScrollb.ThumbTexture     :SetHeight(WO.fonts.TXT_14)
			  InfosScrollb.ScrollDownButton :SetWidth( WO.fonts.TXT_14)
			  InfosScrollb.ScrollDownButton :SetHeight(WO.fonts.TXT_14)
			  InfosScrollb.ScrollUpButton   :SetWidth( WO.fonts.TXT_14)
			  InfosScrollb.ScrollUpButton   :SetHeight(WO.fonts.TXT_14)

		local Infoschild = WO:FRAM("WOEZ_OPT_CM_SCRLchild","Frame",InfosScrollF)
			  Infoschild:SetSize(1,1)

			  InfosScrollF:SetScrollChild(Infoschild)
			  InfosScrollF:SetScript("OnMouseWheel", function (self, value) value = value*-1 val = InfosScrollb:GetValue()+value*10 InfosScrollb:SetValue(val) end)
			  InfosScrollb:SetScript("OnMouseWheel", function (self, value) value = value*-1 val = InfosScrollb:GetValue()+value*10 InfosScrollb:SetValue(val) end)

		local topFram,HeiFrame = 0,-72

		communities = C_Club.GetSubscribedClubs()
		local nb_communities = 0
		for _,community in pairs(communities) do
			if (community.clubType == 1) then
				nb_communities = nb_communities + 1
				local line = WO:FRAM("WOEZ_OPT_CM_"..community.clubId,"CheckButton",Infoschild,"ChatConfigCheckButtonTemplate",nil,nil,nil,nil,nil,WO.fonts.TXT_18,WO.fonts.TXT_18)
				local line_txt = WO:FONT("WOEZ_OPT_CM_"..community.clubId.."_txt",line,"LEFT",line,"RIGHT",WO.sizes.MMARGS,-.5, nil,nil,WO.fonts.TTL_F,"LEFT")
					  line_txt:SetText(community.name)
					  line_txt:SetTextColor(1,1,1,1)
					  line:SetPoint("TOPLEFT",2,topFram)
					  line:SetScript("OnClick", function(self, button) if self:GetChecked() then WO_ez_DBC.communities[community.clubId] = true else WO_ez_DBC.communities[community.clubId] = nil end WO:SET_CALENDARLIST(true) end)
					  if WO_ez_DBC.communities[community.clubId] then line:SetChecked(true) end
				topFram  = topFram -22
				HeiFrame = HeiFrame+22
			end
		end
		if nb_communities == 0 then
			local line = WO:FONT("WOEZ_OPT_CM__txt",Infoschild,"LEFT",Infoschild,"RIGHT",WO.sizes.MARGES)
				  line:SetText("...")
				  line:SetTextColor(1,1,1,.4)
				  line:SetPoint("TOPLEFT",4,topFram)
		end

		local WOEZ_OPT_CM_inf = WO:FONT("WOEZ_OPT_CM_inf",self,"TOPLEFT",InfosScrollF,"BOTTOMLEFT",6,-6, nil,nil,WO.fonts.TTL_F,"LEFT")
			  WOEZ_OPT_CM_inf:SetText(L["Details_Commun_L1"].." "..L["Details_Commun_L2"])
			  WOEZ_OPT_CM_inf:SetTextColor(1,1,1,.4)
			  WOEZ_OPT_CM_inf:SetWidth(210)
			  WOEZ_OPT_CM_inf:SetWordWrap(true)

		-- ---------------------------------------------------------------------

		HeiFrame = HeiFrame+7
		if HeiFrame < 2 then HeiFrame = 1 InfosScrollb:Hide() else InfosScrollb:Show() end
		InfosScrollb:SetMinMaxValues(1, HeiFrame)

		-- ---------------------------------------------------------------------

		if WO.player.InGuild then
			--HShowRank = HShowRank+30

			local infos = {}
			for i=2, GuildControlGetNumRanks() do
				local Nameg = GuildControlGetRankName(i)
				if Nameg then infos[i] = Nameg end
			end

			local ShowGMrank = WO:FONT("WOEZ_OPT_GM",self,  "TOPLEFT", WOEZ_OPT_CM_inf, "BOTTOMLEFT", 0, -22,   nil,nil,"GameFontNormal","LEFT")
				  ShowGMrank:SetText(L["Show_GM"])

			local infos = {}
			for i=2, GuildControlGetNumRanks() do
				local Nameg = GuildControlGetRankName(i)
				if Nameg then infos[i] = Nameg end
			end
			local obj = "WOEZ_OPT_GMR"
			local GMRankDropdown = _G[obj] or CreateFrame("Frame",obj, self, "UIDropDownMenuTemplate")
				  GMRankDropdown:SetPoint("TOPLEFT",ShowGMrank,"BOTTOMLEFT",-18,-2)
				  GMRankDropdown.initialize = function()
						info = {}
						for u, grank in pairs(infos) do
							info.text = grank
							info.value = u
							info.func = function(self)
								WO_ez_DBC.guildrankGM = self.value
								info.checked = self.value == self.text
								UIDropDownMenu_SetText(GMRankDropdown, self:GetText())
								WO:SET_CALENDARLIST(true)
							end
							info.checked = u == WO_ez_DBC.guildrankGM
							UIDropDownMenu_AddButton(info)
						end
				  end
			if infos[WO_ez_DBC.guildrankGM] then UIDropDownMenu_SetText(GMRankDropdown, infos[WO_ez_DBC.guildrankGM]) end
			GMRankDropdown:Show()

			HShowRank = HShowRank-32

		end
		-- ---------------------------------------------------------------------
		-- ---------------------------------------------------------------------
	end
	self:refresh()
	self:SetScript("OnShow", nil)
end)


-- -----------------------------------------------------------------------------
-- options options
-- -----------------------------------------------------------------------------

SLASH_WOEZ1 = "/woez"
SlashCmdList.WOEZ = function()
	InterfaceOptionsFrame_OpenToCategory(Options)
	InterfaceOptionsFrame_OpenToCategory(Options)
end

-- -----------------------------------------------------------------------------