-- Author      : Lars
-- Create Date : 9/10/2009 12:48:21 PM
local bb_version = "r90910";

function BottomFrame_OnLoad()
    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000BottomBar|r "..bb_version.." |cFFFF0000loaded.");
    end
    
	if (type(bb_height) == "nil") then
		bb_height = 100;
	end
	if (type(bb_alpha) == "nil") then
		bb_alpha = 1;
	end
	
	this:RegisterEvent("VARIABLES_LOADED");
	
	SlashCmdList["BOTTOM_FRAME_CONFIG"] = bb_command;
    SLASH_BOTTOM_FRAME_CONFIG1="/bottombar";
end

function bb_command(arg)
	pref_alpha:SetValue(bb_alpha * 10);
	pref_height:SetText(bb_height);	
	BBConfigFrame:Show();
	--[[
	a, b = strsplit(" ", arg);
	if (a == "height") then
		if (type(tonumber(b)) == "number") then
			BBBottomFrame:SetHeight(b + 50);
			bb_height = b;
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000height must be a number");
		end
	elseif (a == "alpha") then
		if ((type(tonumber(b)) == "number") and (tonumber(b) >= 0) and (tonumber(b) <= 1)) then
			BBBottomFrame:SetAlpha(b);
			bb_alpha = b;
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000alpha must be a floating-point number between 0 and 1");
		end
	else
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000BottomBar");
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000 > /bottombar height|r value");
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000 > /bottombar alpha|r 0 <= value <= 1");
	end
	--]]
end

function BottomFrame_OnEvent()
	if (event == "VARIABLES_LOADED") then	
		BBBottomFrame:SetHeight(bb_height + 50);
		BBBottomFrame:SetAlpha(bb_alpha);
	end
end

function bb_pref_btn_cancel_OnClick()
	BBConfigFrame:Hide();
end

function pref_alpha_OnValueChanged()	
	pref_alpha_value:SetText(pref_alpha:GetValue()/10);
end

function bb_pref_btn_ok_OnClick()
	BBBottomFrame:SetAlpha(pref_alpha:GetValue()/10);
	bb_alpha = pref_alpha:GetValue()/10;
	BBBottomFrame:SetHeight(pref_height:GetText() + 50);
	bb_height = pref_height:GetText();
	BBConfigFrame:Hide();
end
