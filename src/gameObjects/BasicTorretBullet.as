package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BehaviourComponents.EnemyPursuit;
	import GameObjectComponents.Explosion;
	import GameObjectComponents.LifeTime;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BasicTorretBullet extends GameObject 
	{
		
		private var enemy:GameObject;
		
		public function BasicTorretBullet(enemy:GameObject) 
		{
			this.enemy = enemy;
			
			addComponent(new BoundingCircle(4));
			addComponent(new BoundingShapeRenderer(0xBC6501));
			addComponent(new Mover(new Vector3D(), 0, 0));
			addComponent(new EnemyPursuit(enemy));
			addComponent(new LifeTime(1));
			addComponent(new Explosion(true, 0xBC6501));
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			
			if (other is Enemy) {
				other.handleMessage("damage");
				//this.handleMessage("explode");
				this.destroyed = true;
			}
			
			super.afterCollisionWith(other);
		}
		
	}

}