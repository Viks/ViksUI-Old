local _,ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF

local _, playerClass = UnitClass("player")
if cfg.IndicatorIcons2 == true then return end
local Enable = function(self)
	if self.DrkIndicators then
		self.NumbersIndicator = self.Health:CreateFontString(nil,"OVERLAY")
		self.NumbersIndicator:ClearAllPoints()
		self.NumbersIndicator:SetPoint("BOTTOMRIGHT",self.Health,"BOTTOMRIGHT",4,-4)
		self.NumbersIndicator:SetFont(cfg.font,13,"THINOUTLINE")
		self.NumbersIndicator.frequentUpdates = .25
		self:Tag(self.NumbersIndicator,cfg.IndicatorList["NUMBERS"][playerClass])
	
		self.SquareIndicator = self.Health:CreateFontString(nil,"OVERLAY")
		self.SquareIndicator:ClearAllPoints()
		self.SquareIndicator:SetPoint("BOTTOMRIGHT",self.NumbersIndicator,"BOTTOMLEFT",3,1)
		self.SquareIndicator:SetFont(cfg.squarefont,10,"THINOUTLINE")
		self.SquareIndicator.frequentUpdates = .25
		self:Tag(self.SquareIndicator,cfg.IndicatorList["SQUARE"][playerClass])
	end
end

oUF:AddElement('DrkIndicators',nil,Enable,nil)
