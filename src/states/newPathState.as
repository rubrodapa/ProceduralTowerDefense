package states 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BasicTowerShooter;
	import gameObjects.MegaEnemy;
	import nl.jorisdormans.phantom2D.ai.statemachines.State;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class newPathState extends State 
	{
		
		private var objectLayer:TiledObjectLayer;
		private var x:Number;
		private var y:Number;
		private var enemySize:Number;
		private var timer:Number;
		private var enemy:GameObject;
		private var bool:Boolean = false;
		private var level:Number;
		public function newPathState(enemySize:Number, x:Number, y:Number, level:Number) 
		{
			this.x = x;
			this.y = y;
			this.enemySize = enemySize;
			timer = 2;
			this.level = level;
		}
		
		override public function onActivate():void 
		{
			super.onActivate();
			objectLayer = stateMachine.parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer;
		}
		
		override public function update(elapsedTime:Number):void 
		{	
			super.update(elapsedTime);
			timer -= elapsedTime;
			if (timer < 0 && !bool) {
				objectLayer.addGameObjectSorted(enemy = new MegaEnemy(enemySize), new Vector3D(x, y));
				bool = true;
			}
			
			if (bool) {
				if(enemy.destroyed){
					switch(level) {
						case 2:
							this.stateMachine.popState();
							stateMachine.addState(new SecondState());
							break;
						case 4:
							this.stateMachine.popState();
							stateMachine.addState(new FourthState());
					}
				}
			}
		}
		
	}

}