package AI 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class AIManeuver extends GameObjectComponent 
	{
		
		private var velocity:Vector3D = new Vector3D();
		
		public function AIManeuver() 
		{
			
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if (!gameObject.mover) {
				throw new Error("GameObject needs a Mover");
			}
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				
				case "goLeft":
					velocity = new Vector3D( -80, 0);
					return Phantom.MESSAGE_HANDLED;
				case "goUp":
					velocity = new Vector3D( 0, -80);
					return Phantom.MESSAGE_HANDLED;
				case "goRight":
					velocity = new Vector3D( 80, 0);
					return Phantom.MESSAGE_HANDLED;
				case "goDown":
					velocity = new Vector3D( 0, 80);
					return Phantom.MESSAGE_HANDLED;
				case "interwall":
					gameObject.mover.velocity = new Vector3D(Math.random() * 20, Math.random() * 20);
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			gameObject.mover.velocity = velocity.clone();
		}
		
	}

}