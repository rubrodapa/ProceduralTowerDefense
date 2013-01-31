package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import gameObjects.Path;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class CreatePatch extends GameObjectComponent 
	{
		
		public function CreatePatch() 
		{
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				
				case "createPath":
					var pos:Vector3D = data as Vector3D;
					gameObject.objectLayer.addGameObjectSorted(new Path(), (gameObject.objectLayer as TiledObjectLayer).getTile(pos).getPosition());
					return Phantom.MESSAGE_HANDLED;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}