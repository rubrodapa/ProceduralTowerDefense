package GameObjectComponents 
{
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class smokeIntensity extends GameObjectComponent 
	{
		
		private var intensity:Number;
		
		public function smokeIntensity() 
		{
			intensity = 5;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (intensity > 0)
				intensity -= elapsedTime;
			else
				gameObject.destroyed = true;
			
			super.update(elapsedTime);
		}
		
		override public function getProperty(property:String, data:Object = null, componentClass:Class = null):Object 
		{
			switch(property) {
				case "intensity":
					return this.intensity;
			}
			
			return super.getProperty(property, data, componentClass);
		}
		
	}

}