local function createList(parent, name)
	local parent = CreateFrame("ScrollFrame", name, parent, "UIPanelScrollFrameTemplate")
	parent:SetPoint("TOPLEFT", 3, -4)
	parent:SetPoint("BOTTOMRIGHT", -27, 4)
	local child = CreateFrame("Frame")
	parent:SetScrollChild(child)
	child:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth() - 18)
	child:SetHeight(1)
	local title = child:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetPoint("TOP")
	title:SetText("MyAddOn")
	local footer = child:CreateFontString("ARTWORK", nil, "GameFontNormal")
	footer:SetPoint("TOP", 0, -5000)
	footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")
end

function NAW:InitializeOptions()
	self.options = CreateFrame("Frame")
	-- self.options.name = TTOM.notes
	InterfaceOptions_AddCategory(self.options)
end
