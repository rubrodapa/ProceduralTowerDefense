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
	public class FourthState extends State 
	{
		
		private var pedestal:GameObject;
		private var objectLayer:TiledObjectLayer;
		private var previousPedestalLife:Number;
		private var timeToChangeState:Number;
		
		
		private var enemySpawnerLeft:EnemySpawner;
		private var enemySpawnerRight:EnemySpawner;
		
		public function FourthState() 
		{
			timeToChangeState = 40;
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
			
			pedestal = objectLayer.getObjectByClass(Pedestal);
			previousPedestalLife = pedestal.getProperty("life") as Number;
			
			objectLayer.addComponent(enemySpawnerLeft = new EnemySpawner( -10, 300, 2));
			objectLayer.addComponent(enemySpawnerRight = new EnemySpawner(840, 300, 2));
			
			objectLayer.addComponent(new EnemySpawner(400, -10, 2));
			
		}
		
		override public function onRemove():void 
		{
			//objectLayer.removeComponent(enemySpawnerLeft);
			//objectLayer.removeComponent(enemySpawnerRight);
			super.onRemove();
		}
		
		override public function update(elapsedTime:Number):void 
		{
			timeToChangeState -= elapsedTime;
			
			var life:Number = pedestal.getProperty("life") as Number;
			if (previousPedestalLife != life) {
				timeToChangeState = 40;
				previousPedestalLife = life;
			}
			
			if (timeToChangeState <= 0) {
				stateMachine.parent.handleMessage("changeState");
				stateMachine.popState();
				stateMachine.addState(new fiveState());
			}
			
			super.update(elapsedTime);
		}
		
	}

}