package GameObjectComponents.BehaviourComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class SeekPedestal extends GameObjectComponent 
	{
		
		private var pedestal:GameObject;
		private var maxVelocity:Number = 40;
		
		public function SeekPedestal() 
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
			pedestal = gameObject.objectLayer.getObjectByClass(Pedestal);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			if(pedestal){
				
				var desiredVelocity:Vector3D = pedestal.position.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(maxVelocity);
				var finalVelocity:Vector3D = gameObject.mover.velocity.add(desiredVelocity);
				
				if (finalVelocity.length > 80) {
					finalVelocity.scaleBy(80 / finalVelocity.length);
				}
				
				gameObject.mover.velocity = finalVelocity;
			}
			
		}
		
	}

}