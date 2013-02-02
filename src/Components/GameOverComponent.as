package Components 
{
	import nl.jorisdormans.phantom2D.core.Component;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class GameOverComponent extends Component 
	{
		
		public function GameOverComponent() 
		{
			
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			if (message == "gameOver") {
				(parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer).handleMessage("stopEnemies");
				
				for each(var go:GameObject in (parent.getComponentByClass(TiledObjectLayer) as TiledObjectLayer).objects) {
					go.handleMessage("finalExplosion");
				}
				
				
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
	}

}