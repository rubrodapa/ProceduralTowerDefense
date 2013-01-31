package GameObjectComponents 
{
	import gameObjects.SuperDamage;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class DamageArea extends GameObjectComponent 
	{
		
		public function DamageArea() 
		{
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			
			switch(message) {
				case "damage":
					gameObject.objectLayer.addGameObjectSorted(new SuperDamage(), gameObject.position);
					return Phantom.MESSAGE_HANDLED;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}