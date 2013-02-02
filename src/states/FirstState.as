package states 
{
	import Components.EnemySpawner;
	import GameObjectComponents.CreatePatch;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class FirstState extends State 
	{
		
		private var objectLayer:TiledObjectLayer;
		private var enemySpawner:EnemySpawner;
		private var pedestal:GameObject;
		private var previousPedestalLife:Number;
		private var timeToChangeState:Number;
		
		public function FirstState() 
		{
			timeToChangeState = 20;
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
			
			pedestal = objectLayer.getObjectByClass(Pedestal);
			previousPedestalLife = pedestal.getProperty("life") as Number;
			
			objectLayer.addComponent(enemySpawner = new EnemySpawner(-10, 300,1));
		}
		
		override public function onRemove():void 
		{
			objectLayer.removeComponent(enemySpawner);
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
				stateMachine.parent.handleMessage("changeState");
				stateMachine.popState();
				stateMachine.addState(new newPathState(40, 840, 300,2));
			}
			
			super.update(elapsedTime);
		}
		
	}

}