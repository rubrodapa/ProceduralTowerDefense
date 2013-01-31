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
	public class PickUpSpawn extends GameObjectComponent 
	{
		
		public function PickUpSpawn() 
		{
			
		}
		
		override public function onRemove():void 
		{
			if (Math.random() < 0.4) {
				var pos:Vector3D = gameObject.position.clone();
				var player:Player = gameObject.objectLayer.getObjectByClass(Player) as Player;
				gameObject.objectLayer.addGameObjectAt(new PickUp(), pos, gameObject.objectLayer.getObjectIndex(player));
			}
			super.onRemove();
		}
		
	}

}