package GameObjectComponents.BehaviourComponents 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class EnemyPursuit extends GameObjectComponent 
	{
		
		private var enemy:GameObject;
		private var maxVelocity:Number = 65;
		
		public function EnemyPursuit(enemy:GameObject) 
		{
			this.enemy = enemy;
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if (!gameObject.mover)
				throw new Error("GameObject needs a Mover");
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			if(enemy){
				
				var temp:Vector3D = new Vector3D();
				
				if(enemy.mover){
					temp = enemy.mover.velocity.clone();
					temp.scaleBy(0.2);
				}	
				
				var enemyPosition:Vector3D = enemy.position.add(temp);
				
				var desiredVelocity:Vector3D = enemyPosition.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(maxVelocity);
				var finalVelocity:Vector3D = gameObject.mover.velocity.add(desiredVelocity);
				
				if (finalVelocity.length > 130) {
					finalVelocity.scaleBy(130 / finalVelocity.length);
				}
				
				gameObject.mover.velocity = finalVelocity;
			}else {
				gameObject.destroyed = true;
			}
		}
		
	}

}