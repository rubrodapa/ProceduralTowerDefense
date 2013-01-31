package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BehaviourComponents.SeekPedestal;
	import GameObjectComponents.CreatePatch;
	import GameObjectComponents.PickUpDestroySpawn;
	import GameObjectComponents.PickUpSpawn;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class MegaEnemy extends GameObject 
	{
		
		public function MegaEnemy(size:Number = 50) 
		{
			addComponent(new BoundingBoxAA(new Vector3D(size, size)));
			addComponent(new BoundingShapeRenderer(0x111111));
			addComponent(new Mover(new Vector3D( -100, 0)));
			addComponent(new SeekPedestal());
			addComponent(new CreatePatch());
			addComponent(new PickUpDestroySpawn());
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other is Walls || other is InternalWall || other is BasicTower) {
				other.handleMessage("explode");
				this.handleMessage("createPath", other.position);
				this.handleMessage("spawnPickup", other.position);
			}else if (other is Pedestal) {
				this.destroyed = true;
			}
			
			super.afterCollisionWith(other);
		}
		
		override public function canCollideWith(other:GameObject):Boolean 
		{
			if (other is PickUp)
				return false;
			
			return super.canCollideWith(other);
		}
		
		
	}

}