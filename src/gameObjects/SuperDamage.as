package gameObjects 
{
	import GameObjectComponents.BiggerSmallerCircle;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class SuperDamage extends GameObject 
	{
		
		public function SuperDamage() 
		{
			addComponent(new BoundingCircle(10));
			addComponent(new BoundingShapeRenderer(0xFFFFFF, 0X000000, 3));
			addComponent(new BiggerSmallerCircle());
		}
		
		override public function canCollideWith(other:GameObject):Boolean 
		{
			return false;
		}
		
	}

}