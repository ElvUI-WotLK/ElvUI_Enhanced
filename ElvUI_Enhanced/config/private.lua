local E, L, V, P, G = unpack(ElvUI);

V.general.pvpautorelease = true;
V.general.autorepchange = true;
V.general.selectquestreward = true;
V.general.useoldtabtarget = false;

V.general.minimap.hideincombat = false;
V.general.minimap.fadeindelay = 5;
V.general.minimap.locationdigits = 1;

V.equipment = {
	durability = {
		enable = true,
		onlydamaged = false
	},
	itemlevel = {
		enable = true
	},
	misc = {
		setoverlay = true
	}
};

V.watchframe = {
	enable = true
};