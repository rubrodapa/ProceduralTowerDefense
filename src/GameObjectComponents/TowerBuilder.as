package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.BasicTower;
	import gameObjects.InternalWall;
	import gameObjects.Path;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class TowerBuilder extends GameObjectComponent
	{
		
		private var towerEnergyCost:Number;
		
		
		public function TowerBuilder(towerEnergyCost:Number = 50) 
		{
			this.towerEnergyCost = towerEnergyCost;
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				case "buildTower":
						build();
					return Phantom.MESSAGE_HANDLED;
					break;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
		private function build():void {
			
			var pos:Vector3D = gameObject.position.clone();
			var objects:Vector.<GameObject> = (gameObject.objectLayer as TiledObjectLayer).getTile(pos).objects;
			var bol:Boolean = true;
			for each (var go:GameObject in objects) {
				if (go is InternalWall || go is BasicTower || go is Pedestal || go is Path) {
					bol = bol && false;
				}
			}
			
			if (bol) {
				if((gameObject.getProperty("energy") as Number) >= towerEnergyCost){
					gameObject.objectLayer.addGameObjectSorted(new BasicTower(), (gameObject.objectLayer as TiledObjectLayer).getTile(pos).getPosition());
					gameObject.handleMessage("decrementEnergy", towerEnergyCost);
				}else {
					gameObject.handleMessage("errorBip");
				}
			}else {
				gameObject.handleMessage("errorBip");
			}
		}
		
	}

}