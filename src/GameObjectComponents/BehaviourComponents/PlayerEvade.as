package GameObjectComponents.BehaviourComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.Player;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class PlayerEvade extends GameObjectComponent 
	{
		
		private var player:GameObject;
		private var maxVelocity:Number = 50;
		
		public function PlayerEvade() 
		{
			
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if (!gameObject.mover)
				throw new Error("GameObject needs a Mover");
		}
		
		override public function onInitialize():void 
		{
			super.onInitialize();
			player = gameObject.objectLayer.getObjectByClass(Player);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			if(player){
				
				var desiredVelocity:Vector3D = player.position.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(maxVelocity);
				var finalVelocity:Vector3D = gameObject.mover.velocity.subtract(desiredVelocity);
				
				if (finalVelocity.length > 80) {
					finalVelocity.scaleBy(80 / finalVelocity.length);
				}
				
				gameObject.mover.velocity = finalVelocity;
			}
		}
		
		
		
	}

}