package Components 
{
	import flash.geom.Vector3D;
	import gameObjects.Enemy;
	import nl.jorisdormans.phantom2D.core.Component;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class EnemySpawner extends Component 
	{
		
		private var x:Number;
		private var y:Number;
		private var time:Number;
		private var actualTime:Number;
		private var objectLayer:TiledObjectLayer;
		private var sfxr:SfxrSynth;
		
		public function EnemySpawner(x:Number,y:Number,time:Number = 1) 
		{
			this.x = x;
			this.y = y;
			this.time = time;
			this.actualTime = time;
			sfxr = new SfxrSynth();
			sfxr.params.setSettingsString("1,0.2077,0.169,0.2021,0.3068,0.5883,,-0.1016,-0.1125,0.579,0.1063,-0.842,-0.7708,0.5458,-0.0014,,-0.1,-0.799,0.9657,-0.3417,-0.2071,0.0011,-0.4849,0.5");
			sfxr.cacheSound();
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			objectLayer = composite as TiledObjectLayer;
			if (!objectLayer) {
				throw new Error("EnemySpawner must be added to an TiledObjectLayer");
			}
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			actualTime -= elapsedTime;
			if (actualTime < 0) {
				actualTime = time;
				spawn();
			}
		}
		
		private function spawn():void {
			
			var enemyObject:GameObject = new Enemy();
			if (enemyObject) {
				sfxr.play();
				objectLayer.addGameObjectSorted(enemyObject, new Vector3D(x, y));
			}
			
		}
		
	}

}