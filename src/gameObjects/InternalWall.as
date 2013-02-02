package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.Explosion;
	import GameObjectComponents.FinalExplosion;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class InternalWall extends GameObject 
	{
		
		public function InternalWall() 
		{
			addComponent(new BoundingBoxAA(new Vector3D(33, 33)));
			addComponent(new BoundingShapeRenderer(0xAA9628,0x000000,2));
			addComponent(new Explosion(true, 0xAF9F2F));
			addComponent(new FinalExplosion());
		}
		
	}

}