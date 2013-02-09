package gameObjects 
{
	import AI.AIManeuver;
	import AI.BreadCrumbsSpawner;
	import AI.EnemyAI;
	import flash.geom.Vector3D;
	import GameObjectComponents.BehaviourComponents.EvadeTowers;
	import GameObjectComponents.Explosion;
	import GameObjectComponents.LifeComponent;
	import GameObjectComponents.PickUpSpawn;
	import nl.jorisdormans.phantom2D.objects.boundaries.DestroyOutsideLayer;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class IntelEnemy extends GameObject 
	{
		
		public function IntelEnemy() 
		{
			addComponent(new BoundingBoxAA(new Vector3D(20, 20)));
			addComponent(new BoundingShapeRenderer(0xff00ff));
			addComponent(new Mover(new Vector3D(), 0, 0));
			addComponent(new EvadeTowers());
			addComponent(new Explosion(true, 0xff00ff));
			addComponent(new LifeComponent(1, false));
			addComponent(new PickUpSpawn());
			addComponent(new EnemyAI());
			addComponent(new AIManeuver());
			addComponent(new BreadCrumbsSpawner());
			addComponent(new DestroyOutsideLayer(60));
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other as Pedestal) {
				other.handleMessage("damage");
				this.handleMessage("explode");
			}else if (other as InternalWall) {
				this.handleMessage("interwall");
			}
			
			super.afterCollisionWith(other);
		}
		
	}

}