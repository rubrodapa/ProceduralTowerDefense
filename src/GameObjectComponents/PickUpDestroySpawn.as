package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.PickUp;
	import gameObjects.Player;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class PickUpDestroySpawn extends GameObjectComponent 
	{
		
		public function PickUpDestroySpawn() 
		{
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				case "spawnPickup":
					if (Math.random() < 0.4) {
					var pos:Vector3D = data as Vector3D;
					var player:Player = gameObject.objectLayer.getObjectByClass(Player) as Player;
					gameObject.objectLayer.addGameObjectAt(new PickUp(), pos, gameObject.objectLayer.getObjectIndex(player));
				}
			}			
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}