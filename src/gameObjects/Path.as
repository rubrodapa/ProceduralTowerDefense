package gameObjects 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Path extends GameObject 
	{
		
		public function Path() 
		{
			addComponent(new BoundingBoxAA(new Vector3D(40, 40)));
			//addComponent(new BoundingShapeRenderer(0x888888));
			doResponse = false;
		}
		
		
		
	}

}