package gameObjects 
{
	import GameObjectComponents.BasicTowerShooter;
	import GameObjectComponents.Explosion;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BasicTower extends GameObject 
	{
		
		public function BasicTower() 
		{
			addComponent(new BoundingCircle(15));
			addComponent(new BoundingShapeRenderer(0x52E2E2, 0x000000, 2));
			addComponent(new BasicTowerShooter());
			addComponent(new Explosion(true));
		}
		
	}

}