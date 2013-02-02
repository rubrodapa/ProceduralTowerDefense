package Components 
{
	import nl.jorisdormans.phantom2D.core.Component;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class WinOverComponent extends Component 
	{
		
		private var sound:Boolean = false;
		private var time:Number = 0;
		
		public function WinOverComponent() 
		{
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			if (message == "win") {
				(parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer).handleMessage("stopEnemies");
				sound = true;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			
			super.update(elapsedTime);
			if (time <= 0) {
				time = 20;
				parent.handleMessage("winSound");
			}
			
			if(time > 0) time -= elapsedTime;
		}
		
	}

}