package GameObjectComponents 
{
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BoundingCircleSmaller extends GameObjectComponent 
	{
		
		private var boundingCircle: BoundingCircle;
		private var velocity: Number;
		
		public function BoundingCircleSmaller() 
		{
			velocity = 1;
		}
		
		override public function onInitialize():void 
		{
			boundingCircle = gameObject.getComponentByClass(BoundingCircle) as BoundingCircle;
			if (!boundingCircle)
				trace("Parent needs a BoundginCircle component")
			super.onInitialize();
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if(boundingCircle.radius > 0)
				boundingCircle.radius -= velocity * elapsedTime;
			if(boundingCircle.radius < 0)
				boundingCircle.radius = 0;
			if(velocity<8) velocity += 0.5;
			if (boundingCircle.radius < 2) {
				gameObject.handleMessage("bombExplosion");
			}
			
			super.update(elapsedTime);
		}
		
	}

}