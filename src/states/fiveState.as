package states 
{
	import Components.EnemySpawner;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class fiveState extends State 
	{
		private var pedestal:GameObject;
		private var objectLayer:TiledObjectLayer;
		private var previousPedestalLife:Number;
		private var timeToChangeState:Number;
		
		public function fiveState() 
		{
			timeToChangeState = 40;
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
			
			pedestal = objectLayer.getObjectByClass(Pedestal);
			previousPedestalLife = pedestal.getProperty("life") as Number;
			
			objectLayer.addComponent(new EnemySpawner( 400, 610, 2));
			
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
				stateMachine.addState(new SixState());
			}
			
			super.update(elapsedTime);
		}
		
	}

}