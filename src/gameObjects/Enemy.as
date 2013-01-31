package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BehaviourComponents.SeekPedestal;
	import GameObjectComponents.Explosion;
	import GameObjectComponents.LifeComponent;
	import GameObjectComponents.PickUpSpawn;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Enemy extends GameObject 
	{
		
		public function Enemy() 
		{
			addComponent(new BoundingBoxAA(new Vector3D(20, 20)));
			addComponent(new BoundingShapeRenderer(0xff00ff));
			addComponent(new Mover(new Vector3D(), 0, 0));
			addComponent(new SeekPedestal());
			addComponent(new Explosion(true, 0xff00ff));
			addComponent(new LifeComponent(1, false));
			addComponent(new PickUpSpawn());
		}
		
		override public function canCollideWith(other:GameObject):Boolean 
		{
			if (other as Path)
				return false;
			
			return super.canCollideWith(other);
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other as Pedestal) {
				other.handleMessage("damage");
				this.handleMessage("explode");
			}
			
			super.afterCollisionWith(other);
		}
		
	}

}