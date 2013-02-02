package states 
{
	import Components.EnemySpawner;
	import flash.geom.Vector3D;
	import gameObjects.MegaEnemy;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class ThirdState extends State 
	{
		
		private var pedestal:GameObject;
		private var objectLayer:TiledObjectLayer;
		private var previousPedestalLife:Number;
		private var timeToChangeState:Number;
		
		private var enemySpawnerLeft:EnemySpawner;
		private var enemySpawnerRight:EnemySpawner;
		
		public function ThirdState() 
		{
			timeToChangeState = 20;
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
			
			pedestal = objectLayer.getObjectByClass(Pedestal);
			previousPedestalLife = pedestal.getProperty("life") as Number;
			
			objectLayer.addComponent(enemySpawnerLeft = new EnemySpawner( -10, 300, 0.7));
			objectLayer.addComponent(enemySpawnerRight = new EnemySpawner(840, 300,2));
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
				stateMachine.parent.handleMessage("changeState");
				stateMachine.popState();
				objectLayer.addGameObjectSorted(new MegaEnemy(35, false, new Vector3D(100, 0)), new Vector3D(-40, 140));
				objectLayer.addGameObjectSorted(new MegaEnemy(35, false, new Vector3D(100, 0)), new Vector3D(-40, 460));
				objectLayer.addGameObjectSorted(new MegaEnemy(35, false, new Vector3D(0, 100)), new Vector3D( 227, -60));
				objectLayer.addGameObjectSorted(new MegaEnemy(35, false, new Vector3D(0, 100)), new Vector3D( 627, -60));
				objectLayer.addGameObjectSorted(new MegaEnemy(35), new Vector3D(430, 660));
				stateMachine.addState(new newPathState(35, 430, -60, 4));
			}
			
			super.update(elapsedTime);
		}
	}

}