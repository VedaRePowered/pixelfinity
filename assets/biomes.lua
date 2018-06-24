biomes = {
	mountains = {
		blockPerlinLevels = {
			{
				{smoothness=1000, intensity=500},
				{smoothness=100, intensity=100},
				{smoothness=20, intensity=6},
				{smoothness=5, intensity=1}
			},
			{
				{smoothness=20, intensity=4}
			}
		},
		blockNames = {
			"stone",
			"dirt"
		},
		topLayer = "grass",

		layerMinHeights = {
			200,
			2
		},

		structures = {
			trees = {smoothness=1, chance=10}
		}
	},
	plains = {
		blockPerlinLevels = {
			{
				{smoothness=1000, intensity=15},
				{smoothness=100, intensity=5}
			},
			{
				{smoothness=100, intensity=2}
			}
		},
		blockNames = {
			"stone",
			"dirt"
		},
		topLayer = "grass",

		layerMinHeights = {
			200,
			3
		},

		structures = {
			trees = {smoothness=10, chance=20}
		}
	}
}

return biomes
