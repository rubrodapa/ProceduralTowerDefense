package GameObjectComponents 
{
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class LifeTime extends GameObjectComponent 
	{
		
		private var time:Number;
		private var alphaDown:Boolean;
		private var render:BoundingShapeRenderer;
		private var initialTime:Number;
		
		public function LifeTime(time:Number = 2, alphaDown:Boolean = false) 
		{
			this.time = time;
			this.initialTime = time;
			this.alphaDown = alphaDown;
		}
		
		override public function onInitialize():void 
		{
			super.onInitialize();
			if (alphaDown) {
				render = gameObject.getComponentByClass(BoundingShapeRenderer) as BoundingShapeRenderer;
				if (!render)
					throw new Error("GameObject needs a BoundingShapeRenderer  when using alpha");
			}
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			if (time < 0) {
				gameObject.destroyed = true;
			}
			else {
				time -= elapsedTime;
				if (alphaDown) {
					render.alpha = time / initialTime;
				}
			}
		}
		
	}

}