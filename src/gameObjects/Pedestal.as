package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.DamageArea;
	import GameObjectComponents.Explosion;
	import GameObjectComponents.LifeComponent;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingPolygon;
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Pedestal extends GameObject
	{
		
		public function Pedestal() 
		{
			addComponent(new BoundingPolygon(new Vector3D( -15, 0), new Vector3D( -8, 13), new Vector3D(8, 13), new Vector3D(15, 0), new Vector3D(8, -13), new Vector3D( -8, -13)));
			addComponent(new BoundingShapeRenderer(0x00FF00, 0x000000, 1));
			addComponent(new LifeComponent());
			addComponent(new Explosion());
			addComponent(new DamageArea());
		}
		
	}

}