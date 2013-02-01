package GameObjectComponents.BehaviourComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.BasicTower;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.Tile;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class EvadeTowers extends GameObjectComponent 
	{
		
		private var maxVelocity:Number = 40;
		private var nearTowers:Vector.<GameObject>;
		
		public function EvadeTowers() 
		{
			nearTowers = new Vector.<GameObject>();
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
			
			lookForNearTowers();
			
			var temporalVelocity:Vector3D = new Vector3D();
			
			for each (var go:GameObject in nearTowers) {
				
				var desiredVelocity:Vector3D = go.position.subtract(gameObject.position);
				desiredVelocity.normalize();
				desiredVelocity.scaleBy(maxVelocity);
				
				temporalVelocity = temporalVelocity.add(gameObject.mover.velocity.subtract(desiredVelocity));
				
			}
			
			if (temporalVelocity.length > 30) {
				temporalVelocity.scaleBy(30 / temporalVelocity.length);
			}
			
				gameObject.mover.velocity = gameObject.mover.velocity.add(temporalVelocity).clone();
			
		}
		
		private function lookForNearTowers() :void{
			
			var tile:Tile = (gameObject.objectLayer as TiledObjectLayer).getTile(gameObject.position);
			
			nearTowers = new Vector.<GameObject>;
			
			if(tile.up){
				for each(var go:GameObject in tile.up.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
				}
				
				if(tile.up.left){
					for each(go in tile.up.left.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
					}
				}
				
				if (tile.up.right) {
					for each(go in tile.up.right.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
					}
				}
			}
			
			if(tile.down){
				for each(go in tile.down.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
				}
				
				if (tile.down.right) {
					for each(go in tile.down.right.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
					}
				}
			
				if (tile.down.left) {
					for each(go in tile.down.left.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
					}
				}
			}
			
			if(tile.right){
				for each(go in tile.right.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
				}
			}
			
			if(tile.left){
				for each(go in tile.left.objects) {
						if (go is BasicTower) {
							nearTowers.push(go);
						}
				}
			}			
			
		}
		
	}

}