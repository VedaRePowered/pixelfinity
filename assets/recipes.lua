local recipes = {
	{{name="oakplank", amount=1}, out={name="stick", amount=4}},
	{{name="cobblestoneblock", amount=1}, out={name="stone", amount=4}},
	{{name="stone", amount=4}, out={name="cobblestoneblock", amount=1}},
	{{name="oakplank", amount=2}, out={name="oakwoodblock", amount=1}},
	{{name="oakplank", amount=4}, {name="oakbark", amount=1}, out={name="oaklogblock", amount=1}},
	{{name="stick", amount=2}, {name="stone", amount=3}, out={name="stonepickaxe", amount=1}},
	{{name="stick", amount=2}, {name="stone", amount=2}, out={name="stoneaxe", amount=1}},
	{{name="stick", amount=2}, {name="stone", amount=2}, out={name="stoneshovel", amount=1}},
	{{name="stick", amount=2}, {name="oakplank", amount=6}, out={name="woodpickaxe", amount=1}},
	{{name="stick", amount=2}, {name="oakplank", amount=4}, out={name="woodaxe", amount=1}},
	{{name="stick", amount=2}, {name="oakplank", amount=4}, out={name="woodshovel", amount=1}}
}

return recipes
