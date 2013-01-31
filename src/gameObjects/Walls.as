package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.Explosion;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Walls extends GameObject 
	{
		
		public function Walls() 
		{
			addComponent(new BoundingBoxAA(new Vector3D(40, 40)));
			addComponent(new BoundingShapeRenderer(0x000000));
			addComponent(new Explosion());
		}
		
	}

}