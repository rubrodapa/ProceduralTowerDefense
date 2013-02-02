package GameObjectComponents 
{
	import gameObjects.Enemy;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.PhantomGame;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BiggerSmallerCircle extends GameObjectComponent 
	{
		
		private var circle:BoundingCircle;
		private var bigger:Boolean = true;
		
		public function BiggerSmallerCircle() 
		{
			
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			circle = gameObject.getComponentByClass(BoundingCircle) as BoundingCircle;
			if (!circle)
				throw new Error("The components needs a BoundingCircle");
		}
		
		override public function update(elapsedTime:Number):void 
		{
			
			if (circle.radius < PhantomGame.gameWidth / 2 && bigger) {
				circle.radius += elapsedTime * 500;
			}
			
			if (circle.radius >= PhantomGame.gameWidth / 2 && bigger) {
				for each(var go:GameObject in gameObject.objectLayer.getAllObjectsOfClass(Enemy)) {
					go.handleMessage("explode");
				}
				
				bigger = false;
			}
			
			if (!bigger) {
				circle.radius -= elapsedTime * 500;
				if (circle.radius < 0) {
					gameObject.destroyed = true;
				}
			}
			
			super.update(elapsedTime);
		}
		
	}

}