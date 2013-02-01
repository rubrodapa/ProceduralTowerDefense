package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class MovementComponent extends GameObjectComponent 
	{
		
		private var v:Vector3D;
		
		public function MovementComponent(velocity:Vector3D) 
		{
			v = velocity;
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if (!gameObject.mover)
				throw new Error("The gameobject needs a mover");
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			gameObject.mover.velocity = v.clone();
		}
		
	}

}