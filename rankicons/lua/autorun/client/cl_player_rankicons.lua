--[[---------------------------------------------------------------------------
Rank Icons Config
---------------------------------------------------------------------------]]
local RankIcons = {}
local function mat(texture) return Material(texture, 'smooth') end
local function addRankIcon( rank, icon )
	RankIcons[rank] = {rank = rank, icon = icon}
end
// Do not touch anything above!
-------------------Easy config for you :)
addRankIcon("Pvt",mat("icons/div/1.png")) --------Whatever you right after addRankIcon is what people need at the start of their name for the rank to show,
addRankIcon("Pfc",mat("icons/div/0.png")) --------you post the image path after mat remeber to use ""
addRankIcon("LCpl",mat("icons/div/2.png"))
addRankIcon("Cpl",mat("icons/div/3.png"))
addRankIcon("Sgt",mat("icons/div/4.png"))
addRankIcon("SSgt",mat("icons/div/5.png"))
addRankIcon("GySgt",mat("icons/div/6.png"))
addRankIcon("MSgt",mat("icons/div/7.png"))
addRankIcon("1stSgt",mat("icons/div/8.png"))
addRankIcon("MGySgt",mat("icons/div/9.png"))
addRankIcon("SgtMaj",mat("icons/div/10.png"))
addRankIcon("AB",mat("icons/div/11.png"))
addRankIcon("Amn",mat("icons/div/12.png"))
addRankIcon("A1C",mat("icons/div/13.png"))
addRankIcon("SrA",mat("icons/div/14.png"))
addRankIcon("ASSgt",mat("icons/div/15.png"))
addRankIcon("TSgt",mat("icons/div/16.png"))
addRankIcon("AMSgt",mat("icons/div/17.png"))
addRankIcon("SMSgt",mat("icons/div/18.png"))
addRankIcon("CMSgt",mat("icons/div/19.png"))
addRankIcon("2ndLt",mat("icons/div/20.png"))
addRankIcon("1stLt",mat("icons/div/21.png"))
addRankIcon("CPT",mat("icons/div/22.png"))
addRankIcon("Maj",mat("icons/div/23.png"))
addRankIcon("LtCol",mat("icons/div/24.png"))
addRankIcon("Col",mat("icons/div/25.png"))
addRankIcon("BGen",mat("icons/div/26.png"))
addRankIcon("MajGen",mat("icons/div/27.png"))
addRankIcon("LtGen",mat("icons/div/28.png"))
addRankIcon("Gen",mat("icons/div/29.png"))
addRankIcon("GAOF",mat("icons/div/30.png"))
addRankIcon("MP",mat("icons/div/31.png"))
-----------------------------DONT TOUCH ANYTHING BELOW THIS LINE

local function DrawRankIcons( self )
	
    local pos = self:EyePos()
	local nick = self:Nick()
	local pattern = "([%w']+)"; -- will match a substring that has one or more letter or apostrophes( ' )
	local start, endpos, nickSub = string.find( nick, pattern )

    pos.z = pos.z + 15 -- Above the head a bit
    pos = pos:ToScreen()

    if RankIcons[nickSub] then
        surface.SetMaterial(RankIcons[nickSub].icon)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(pos.x - 16, pos.y - 74, 40, 40)
    end

end

local function NutScripts_RankIconsView()

	local LP = LocalPlayer()
    local shootPos = LP:GetShootPos()
    local aimVec = LP:GetAimVector()
	local tr = LP:GetEyeTrace()
	local allPlayers = player.GetAll()
	
    for i = 1, #allPlayers do

		local ply = allPlayers[i]

        if ply == LP or not ply:Alive() or ply:GetNoDraw() then continue end

        local hisPos = ply:GetShootPos()

		if hisPos:DistToSqr(shootPos) < 160000 then --Distance from player that it displays

            local pos = hisPos - shootPos

            local unitPos = pos:GetNormalized()

            if unitPos:Dot(aimVec) > 0.45 then

                local trace = util.QuickTrace(shootPos, pos, LP)

                DrawRankIcons(ply)

            end

        end

    end
	
end

local function rIHUD()
	NutScripts_RankIconsView()
end
hook.Add("HUDPaint","drawRankIconsHUD",rIHUD)