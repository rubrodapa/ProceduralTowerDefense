package AI 
{
	import gameObjects.EnemyBreadCrumbs;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.Tile;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BreadCrumbsSpawner extends GameObjectComponent 
	{
		
		private var tiledObjectLayer:TiledObjectLayer;
		private var actualTile:Tile;
		private var previuosTile:Tile;
		
		public function BreadCrumbsSpawner() 
		{
			
		}
		
		override public function onInitialize():void 
		{
			super.onInitialize();
			tiledObjectLayer = gameObject.objectLayer as TiledObjectLayer;
			
			if (!tiledObjectLayer)
				throw new Error("The gameobject needs to be in a tiledObjectLayer");
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			actualTile = tiledObjectLayer.getTile(gameObject.position);
			
			if (actualTile != previuosTile) {
				tiledObjectLayer.addGameObjectSorted(new EnemyBreadCrumbs(), actualTile.getPosition());
			}
			
			previuosTile = actualTile;
			
		}
	}

}