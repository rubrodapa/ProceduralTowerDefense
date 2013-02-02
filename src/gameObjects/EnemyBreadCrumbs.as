package gameObjects 
{
	import GameObjectComponents.smokeIntensity;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class EnemyBreadCrumbs extends GameObject
	{
		
		public function EnemyBreadCrumbs() 
		{
			
			addComponent(new smokeIntensity());
			addComponent(new BoundingCircle(3));
			addComponent(new BoundingShapeRenderer(0xffffff));
			this.doResponse = false;
		}
		
	}

}