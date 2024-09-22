
WOF = {}

-- -----------------------------------------------------------------------------
-- MAIN ------------------------------------------------------------------------

WOF.main = WO:FRAM("WOEZframe","Frame",UIParent,BackdropTemplateMixin and "BackdropTemplate")
WOF.main:SetResizable(true)
WOF.main:Hide()

-- button drag size ------------------------------------------------------------

WOF.main_rb = WO:FRAM("WOEZframeRB","Button",WOF.main,nil,"BOTTOMRIGHT", 1,-1)
WOF.main_rb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
WOF.main_rb:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
WOF.main_rb:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
WOF.main_rb:SetScript("OnMouseDown", function() WOF.main:StartSizing("BOTTOMRIGHT")  end)
WOF.main_rb:SetScript("OnMouseUp"  , function()
	WOF.main:StopMovingOrSizing()
	WO.sizes.PANNEL = WOF.main:GetWidth()
	WO_ez_DBC.width = WO.sizes.PANNEL
	WO:POSITIONS()
end)
WOF.main_rb:SetFrameStrata("MEDIUM")

-- -----------------------------------------------------------------------------
-- Zone progress ---------------------------------------------------------------

WOF.progress = WO:FRAM("WOEZprogress","Frame",WOF.main,BackdropTemplateMixin and "BackdropTemplate")
WOF.progress:SetPoint("TOPLEFT",WOF.main, "BOTTOMLEFT",0,-(WO.sizes.MARGES))
WOF.progress:SetPoint("BOTTOMRIGHT",WOF.main, "BOTTOMRIGHT",0,-(WO.sizes.PANNELPRGSS_H+WO.sizes.MARGES))
WOF.progress_t = WO:FONT("WOEZprogresstext",WOF.progress,"LEFT",WOF.progress,"LEFT",(WO.sizes.MARGES*2),0, -- position
								nil,nil, -- w,h
								WO.fonts.TTL_F ,"LEFT")
WOF.progress_t:SetPoint("RIGHT",WOF.progress,"RIGHT",-(WO.fonts.TXT_22+WO.sizes.MARGES*2),0)
WOF.progress_t:SetText("UPDATING...")
WOF.progress_t:SetTextColor(1,1,1,1)

WOF.progress_b = WO:FRAM("WOEZprogressbtn","Button",WOF.progress,"UIPanelButtonTemplate",
								"RIGHT",-(WO.sizes.MARGES),0,nil,nil, -- position
								WO.fonts.TXT_22,WO.fonts.TXT_22) -- size
WOF.progress_b:SetScript("OnClick", function() WO:PROGRESS_STOP() WO:SET_CALENDARLIST() end)
WOF.progress_b:SetText("x")
WOF.progress:Hide()

-- -----------------------------------------------------------------------------
-- INFOS TOP -------------------------------------------------------------------

WOF.infos = WO:FRAM("WOEZinfos","Frame",WOF.main,nil,"TOPLEFT",WO.sizes.MARGES,-(WO.sizes.MARGES))
WOF.infos:SetPoint("BOTTOMRIGHT",WOF.main, "TOPRIGHT",-(WO.sizes.MARGES),-(WO.sizes.PANNELINFOS_H+WO.sizes.MARGES))

-- -----------------------------------------------------------------------------

WOF.infos_NCmmg_i = WO:ICON("WOezinfosNCmmg_i",WOF.infos,WO.FOLDR .."st_no.tga",
								"RIGHT",-(WO.sizes.MMARGS),0,
								WO.sizes.ICNSUM,WO.sizes.ICNSUM)

WOF.infos_NCmmg_t = WO:FONT("WOezinfosNCmmg_t",WOF.infos,
								"RIGHT",WOF.infos_NCmmg_i,"LEFT",0,0,
								nil,nil, WO.fonts.TTL_F ,"RIGHT")

-- -----------------------------------------------------------------------------

WOF.infos_NRply_i = WO:ICON("WOezinfosNRply_i",WOF.infos,WO.FOLDR .."st_dunno.tga",
								nil,nil,nil,   WO.sizes.ICNSUM,WO.sizes.ICNSUM)
WOF.infos_NRply_t = WO:FONT("WOezinfosNRply_t",WOF.infos,
								"RIGHT",WOF.infos_NRply_i,"LEFT",0,0,
								nil,nil, WO.fonts.TTL_F ,"RIGHT")

-- -----------------------------------------------------------------------------

WOF.infos_Commg_i = WO:ICON("WOezinfosCommg_i",WOF.infos,nil,
								nil,nil,nil,   WO.sizes.ICNSUM,WO.sizes.ICNSUM)
WOF.infos_Commg_t = WO:FONT("WOezinfosCommg_t",WOF.infos,
								"RIGHT",WOF.infos_Commg_i,"LEFT",0,0,
								nil,nil, WO.fonts.TTL_F ,"RIGHT")

-- -----------------------------------------------------------------------------

WOF.infos_Invit_t = WO:FONT("WOezinfosInvit_t",WOF.infos,
								"LEFT",WOF.infos,"LEFT",WO.sizes.MARGES,0,
								nil,nil, WO.fonts.TTL_F ,"LEFT")

-- -----------------------------------------------------------------------------

WOF.infos_NRply_i:SetPoint("RIGHT",WOF.infos_NCmmg_t, "LEFT",-(WO.sizes.MMARGS),0)
WOF.infos_Commg_i:SetPoint("RIGHT",WOF.infos_NRply_t, "LEFT",-(WO.sizes.MMARGS),0)
WOF.infos_Invit_t:SetPoint("RIGHT",WOF.infos_Commg_t, "LEFT",-(WO.sizes.MARGES),0)

-- -----------------------------------------------------------------------------
-- BOTTOM ----------------------------------------------------------------------

WOF.bottom = WO:FRAM("WOEZbottom","Frame",WOF.infos,nil)
WOF.bottom:SetPoint("TOPLEFT"    ,WOF.main, "BOTTOMLEFT"  ,WO.sizes.MARGES,WO.sizes.PANNELINFOS_H+WO.sizes.MARGES)
WOF.bottom:SetPoint("BOTTOMRIGHT",WOF.main, "BOTTOMRIGHT" ,-(WO.sizes.MARGES),WO.sizes.MARGES)

WOF.summa_rangs = WO:ICON("WOezsummarangs",WOF.bottom,WO.FOLDR .."R.tga",
								"RIGHT",-(WO.sizes.MARGES),0,WO.sizes.ICNSUM*1.24,WO.sizes.ICNSUM*1.24)

WOF.sum_rangs_t = WO:FONT("WOezsummrangst",WOF.bottom,
								"RIGHT",WOF.summa_rangs,"LEFT",0,0,nil,nil,WO.fonts.TTL_F,"LEFT")

WOF.summa_meles = WO:ICON("WOezsummameles",WOF.bottom,WO.FOLDR .."M.tga",
								nil,nil,nil,  WO.sizes.ICNSUM*1.24,WO.sizes.ICNSUM*1.24)
WOF.sum_meles_t = WO:FONT("WOezsummmelest",WOF.bottom,
								"RIGHT",WOF.summa_meles,"LEFT",0,0,nil,nil,WO.fonts.TTL_F,"LEFT")

WOF.summa_heals = WO:ICON("WOezsummaheals",WOF.bottom,WO.FOLDR .."H.tga",
								nil,nil,nil,  WO.sizes.ICNSUM*1.24,WO.sizes.ICNSUM*1.24)
WOF.sum_heals_t = WO:FONT("WOezsummhealst",WOF.bottom,
								"RIGHT",WOF.summa_heals,"LEFT",0,0,nil,nil,WO.fonts.TTL_F,"LEFT")

WOF.summa_tanks = WO:ICON("WOezsummatanks",WOF.bottom,WO.FOLDR .."T.tga",
								nil,nil,nil,  WO.sizes.ICNSUM*1.24,WO.sizes.ICNSUM*1.24)
WOF.sum_tanks_t = WO:FONT("WOezsummtankst",WOF.bottom,
								"RIGHT",WOF.summa_tanks,"LEFT",0,0,nil,nil,WO.fonts.TTL_F,"LEFT")

WOF.summa_meles:SetPoint("RIGHT",WOF.sum_rangs_t, "LEFT",-(WO.sizes.MMARGS),0)
WOF.summa_heals:SetPoint("RIGHT",WOF.sum_meles_t, "LEFT",-(WO.sizes.MMARGS),0)
WOF.summa_tanks:SetPoint("RIGHT",WOF.sum_heals_t, "LEFT",-(WO.sizes.MMARGS),0)

WOF.bottnc = WO:FRAM("WOEZbottom_","CheckButton",WOF.bottom,"ChatConfigCheckButtonTemplate","LEFT",WO.sizes.MMARGS,0)
WOF.bottxt = WO:FONT("WOEZbottom_txt",WOF.bottnc,"LEFT",WOF.bottnc,"RIGHT",WO.sizes.MMARGS,0,nil,nil,WO.fonts.TTL_F,"LEFT")
WOF.bottxt:SetText(L["ONLY INVITED"])
WOF.bottxt:SetPoint("RIGHT",WOF.sum_tanks_t,"LEFT",-(WO.sizes.MMARGS),0)

WOF.bottnc:SetScript("OnClick", function()
	if WO_ez_DBC.only_invited then  WO_ez_DBC.only_invited = nil   WOF.bottxt:SetTextColor(.4,.4,.4,1)
							  else  WO_ez_DBC.only_invited = true  WOF.bottxt:SetTextColor(1,1,1,1)    end
	WO:SET_CALENDARLIST()
end)

-- -----------------------------------------------------------------------------
-- MARGES ----------------------------------------------------------------------

WOF.margb = WO:FRAM("WOEZmargb","Frame",WOF.main,nil)
WOF.margb:SetPoint("TOPLEFT"     ,WOF.bottom, "TOPLEFT" ,0,WO.sizes.MARGES)
WOF.margb:SetPoint("BOTTOMRIGHT" ,WOF.bottom, "TOPRIGHT",0,WO.sizes.MMARGS)

WOF.margt = WO:FRAM("WOEZmargt","Frame",WOF.main,nil)
WOF.margt:SetPoint("TOPLEFT"     ,WOF.infos, "BOTTOMLEFT" ,0,-(WO.sizes.MMARGS))
WOF.margt:SetPoint("BOTTOMRIGHT" ,WOF.infos, "BOTTOMRIGHT",0,-(WO.sizes.MARGES))

-- -----------------------------------------------------------------------------
-- SCROLL FRAME ----------------------------------------------------------------

WOF.scrollf = WO:FRAM("WOEZscrollf","ScrollFrame",WOF.infos,nil)
WOF.scrollf:SetPoint("TOPLEFT"    ,WOF.margt, "BOTTOMLEFT",0,0)
WOF.scrollf:SetPoint("BOTTOMRIGHT",WOF.margb, "TOPRIGHT"  ,0,0)

WOF.scrollb = WO:FRAM("WOEZscrollb","Slider",WOF.scrollf,"UIPanelScrollBarTemplate","TOPLEFT", WOF.main,"TOPRIGHT", 4, -(WO.fonts.TXT_14))
WOF.scrollb:SetPoint("BOTTOMLEFT", WOF.main, "BOTTOMRIGHT",0,WO.fonts.TXT_14)
WOF.scrollb:SetMinMaxValues(1, 200)
WOF.scrollb:SetValueStep(10)
WOF.scrollb:SetValue(0)
WOF.scrollb.scrollStep = 10

WOF.scrollb:SetScript("OnValueChanged",function (self, value) self:GetParent():SetVerticalScroll(value) end)

WOF.scrollb                  :SetWidth( WO.fonts.TXT_14)
WOF.scrollb.ThumbTexture     :SetWidth( WO.fonts.TXT_14)
WOF.scrollb.ThumbTexture     :SetHeight(WO.fonts.TXT_14)
WOF.scrollb.ScrollDownButton :SetWidth( WO.fonts.TXT_14)
WOF.scrollb.ScrollDownButton :SetHeight(WO.fonts.TXT_14)
WOF.scrollb.ScrollUpButton   :SetWidth( WO.fonts.TXT_14)
WOF.scrollb.ScrollUpButton   :SetHeight(WO.fonts.TXT_14)

-- -----------------------------------------------------------------------------
-- CHILD -----------------------------------------------------------------------

WOF.child = WO:FRAM("WOEZchild","Frame",WOF.scrollf) WOF.child:SetSize(1,1)

WOF.txtwidth = WO:FRAM("WOEZrosterwidth","Frame",WOF.child,nil,"TOPLEFT",WO.fonts.TXT_14+WO.sizes.MARGES,0)
WOF.txtlevel = WO:FRAM("WOEZrosterlevel","Frame",WOF.txtwidth,nil,"TOPLEFT",WOF.txtwidth,"TOPRIGHT")

WOF.scrollf:SetScrollChild(WOF.child)
WOF.scrollf:SetScript("OnMouseWheel", function (self, value) value = value*-1 val = WOF.scrollb:GetValue()+value*10 WOF.scrollb:SetValue(val) end)
WOF.scrollb:SetScript("OnMouseWheel", function (self, value) value = value*-1 val = WOF.scrollb:GetValue()+value*10 WOF.scrollb:SetValue(val) end)

-- -----------------------------------------------------------------------------
-- NO ELVUI VISUAL -------------------------------------------------------------

if not ElvUI then
	local insideBG = {  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 14 };
	WOF.main       :SetBackdrop(insideBG)
	WOF.progress   :SetBackdrop(insideBG)
end
-- -----------------------------------------------------------------------------


-- DEBUG
-- WOF.main:Show() -- WOF.main:Hide()
-- WOF.progress:Show()
-- WOF.main:SetPoint("TOPLEFT",UIParent,480,-40)
-- WOF.main:SetWidth(400)
-- WOF.main:SetHeight(800)
