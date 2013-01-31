package states 
{
	import Components.EnemySpawner;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class SecondState extends State 
	{
	
		private var pedestal:GameObject;
		private var objectLayer:TiledObjectLayer;
		private var previousPedestalLife:Number;
		private var timeToChangeState:Number;
		private var sfxr:SfxrSynth;
		
		private var enemySpawnerLeft:EnemySpawner;
		private var enemySpawnerRight:EnemySpawner;
		
		public function SecondState() 
		{
			timeToChangeState = 20;
			sfxr = new SfxrSynth();
			sfxr.params.setSettingsString("0,,0.3813,,0.3892,0.2918,,0.4599,,,,,,0.156,,0.6574,,,1,,,,,0.86");
			sfxr.cacheSound();
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
			
			pedestal = objectLayer.getObjectByClass(Pedestal);
			previousPedestalLife = pedestal.getProperty("life") as Number;
			
			objectLayer.addComponent(enemySpawnerLeft = new EnemySpawner( -10, 300, 3));
			objectLayer.addComponent(enemySpawnerRight = new EnemySpawner(840, 300,3));
		}
		
		override public function onRemove():void 
		{
			objectLayer.removeComponent(enemySpawnerLeft);
			objectLayer.removeComponent(enemySpawnerRight);
			super.onRemove();
		}
		
		override public function update(elapsedTime:Number):void 
		{
			timeToChangeState -= elapsedTime;
			
			var life:Number = pedestal.getProperty("life") as Number;
			if (previousPedestalLife != life) {
				timeToChangeState = 20;
				previousPedestalLife = life;
			}
			
			if (timeToChangeState <= 0) {
				sfxr.play();
				stateMachine.popState();
				stateMachine.addState(new ThirdState());
			}
			
			super.update(elapsedTime);
		}
		
	}

}