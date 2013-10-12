------------------------------------------------------------------------------
--KEY MAPPING

KEY_PAUSE 	= 'p';
KEY_BACK 	= 'escape';
KEY_DND		= '1';
KEY_WALKING	= '2';
KEY_ACTION	= ' '

------------------------------------------------------------------------------
--HELPER FUNCTIONS

function RGBA(r,g,b,a)
	if a == nil then
		a = 255
	end
	col = {
		r,g,b,a
	}
	return col;
end

function  keyToString( key )
	if key == ' ' then
		key = 'SPACE';
	end
	return string.upper(key);
end

quitMsg
	= string.format("Press %s anytime to exit / go back",
		keyToString(KEY_BACK));