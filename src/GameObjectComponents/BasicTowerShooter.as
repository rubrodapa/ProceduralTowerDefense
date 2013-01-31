package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.BasicTorretBullet;
	import gameObjects.Enemy;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.Tile;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BasicTowerShooter extends GameObjectComponent 
	{
		
		private var tiledObjectLayer:TiledObjectLayer;
		private var tile:Tile;
		
		private var sfxr:SfxrSynth;
		
		private var timeBetweenShoot:Number;
		private var actualTimerUp:Number;
		private var actualTimerLeft:Number;
		private var actualTimerRight:Number;
		private var actualTimerDown:Number;
		
		public function BasicTowerShooter() 
		{
			timeBetweenShoot = 1.5;
			actualTimerUp = 1.5;
			actualTimerLeft = 1.5;
			actualTimerRight = 1.5;
			actualTimerDown = 1.5;
			
			sfxr = new SfxrSynth();
			sfxr.params.setSettingsString("1,,0.2662,,0.24,0.8101,0.21,-0.28,,,,,0.07,0.1956,0.0955,,,,1,,,,,0.5");
			sfxr.cacheSound();
		}
		
		override public function onInitialize():void 
		{
			super.onInitialize();
			
			tiledObjectLayer = gameObject.objectLayer as TiledObjectLayer;
			if (!tiledObjectLayer)
				throw new Error("The tower needs to be in a tiledObjectLayer");
			
			tile = tiledObjectLayer.getTile(gameObject.position);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			shootUpUpdate(elapsedTime);
			shootRightUpdate(elapsedTime);
			shootDownUpdate(elapsedTime);
			shootLeftUpdate(elapsedTime);
		}
		
		private function shootUpUpdate(elapsedTime:Number):void {
		
			if (actualTimerUp > 0) actualTimerUp -= elapsedTime;
			
			if(actualTimerUp <= 0){
				for each(var go:GameObject in tile.up.objects) {
					if (go is Enemy) {
						var posTemp:Vector3D = gameObject.position.clone();
						sfxr.play();
						gameObject.objectLayer.addGameObjectSorted(new BasicTorretBullet(go), posTemp);
						actualTimerUp = timeBetweenShoot;
					}
				}
			}
			
		}
		
		private function shootRightUpdate(elapsedTime:Number):void {
			
			if (actualTimerRight > 0) actualTimerRight -= elapsedTime;
			
			if(actualTimerRight <= 0){
				for each(var go:GameObject in tile.right.objects) {
					if (go is Enemy) {
						var posTemp:Vector3D = gameObject.position.clone();
						sfxr.play();
						gameObject.objectLayer.addGameObjectSorted(new BasicTorretBullet(go), posTemp);
						actualTimerRight = timeBetweenShoot;
					}
				}
			}
		}
		
		private function shootDownUpdate(elapsedTime:Number):void {
			
			if (actualTimerDown > 0) actualTimerDown -= elapsedTime;
			
			if(actualTimerDown <= 0){
				for each(var go:GameObject in tile.down.objects) {
					if (go is Enemy) {
						var posTemp:Vector3D = gameObject.position.clone();
						sfxr.play();
						gameObject.objectLayer.addGameObjectSorted(new BasicTorretBullet(go), posTemp);
						actualTimerDown = timeBetweenShoot;
					}
				}
			}
			
		}
		
		private function shootLeftUpdate(elapsedTime:Number):void {
			
			if (actualTimerLeft > 0) actualTimerLeft -= elapsedTime;
			
			if(actualTimerLeft <= 0){
				for each(var go:GameObject in tile.left.objects) {
					if (go is Enemy) {
						var posTemp:Vector3D = gameObject.position.clone();
						sfxr.play();
						gameObject.objectLayer.addGameObjectSorted(new BasicTorretBullet(go), posTemp);
						actualTimerLeft = timeBetweenShoot;
					}
				}
			}
			
		}
	}

}