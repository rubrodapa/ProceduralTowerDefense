package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.Bomb;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class BombsThrower extends GameObjectComponent 
	{
		
		private var bombEnergyCost:Number;
		private var sfx:SfxrSynth;
		
		public function BombsThrower(bombEnergyCost:Number = 25) 
		{
			this.bombEnergyCost = bombEnergyCost;
			sfx = new SfxrSynth();
			sfx.params.setSettingsString("1,,0.1271,0.0385,0.76,0.8711,0.2,-0.1514,,,,,,0.7324,-0.2548,,,,1,,,,,0.5");
			sfx.cacheSound();
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				case "throwBomb":
					if ((gameObject.getProperty("energy") as Number) >= bombEnergyCost) {
						var pos:Vector3D = gameObject.position.clone();
						gameObject.objectLayer.addGameObjectAt(new Bomb, pos, gameObject.objectLayer.getObjectIndex(gameObject));
						sfx.play();
						gameObject.handleMessage("decrementEnergy", bombEnergyCost);
					}else {
						gameObject.handleMessage("errorBip");
					}
					return Phantom.MESSAGE_HANDLED;
					break;
				case "reload":
					gameObject.handleMessage("incrementEnergy", bombEnergyCost);
					return Phantom.MESSAGE_HANDLED;
					break;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}