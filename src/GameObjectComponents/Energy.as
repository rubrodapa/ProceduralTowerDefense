package GameObjectComponents 
{
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Energy extends GameObjectComponent 
	{
		
		private var energy:Number;
		private var maxEnergy:Number;
		
		public function Energy(initialEnergy:Number, maxEnergy:Number) 
		{
			this.energy = initialEnergy;
			this.maxEnergy = maxEnergy;
		}
		
		override public function getProperty(property:String, data:Object = null, componentClass:Class = null):Object 
		{
			switch(property) {
				case "energy":
					return energy;
				case "maxEnergy":
					return maxEnergy;
				case "energyLevel":
					var level:Number = energy / maxEnergy;
					level = Math.max(Math.min(1, level), 0);
					return level;
			}
			
			return super.getProperty(property, data, componentClass);
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				case "incrementEnergy":
					this.energy += data as Number;
					this.energy = Math.max(Math.min(this.energy, this.maxEnergy), 0);
					return Phantom.MESSAGE_HANDLED;
				case "decrementEnergy":
					this.energy -= data as Number;
					this.energy = Math.max(Math.min(this.energy, this.maxEnergy), 0);
					return Phantom.MESSAGE_HANDLED;
			}
			return super.handleMessage(message, data, componentClass);
		}
	}

}