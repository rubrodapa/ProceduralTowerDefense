package GameObjectComponents 
{
	import nl.jorisdormans.phantom2D.core.InputState;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.IInputHandler;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class ButtonsHandler extends GameObjectComponent implements IInputHandler 
	{
		
		public function ButtonsHandler() 
		{
			
		}
		
		/* INTERFACE nl.jorisdormans.phantom2D.objects.IInputHandler */
		
		public function handleInput(elapsedTime:Number, currentState:InputState, previousState:InputState):void 
		{
			if (!previousState.keySpace && currentState.keySpace) {
				gameObject.handleMessage("throwBomb");
			}
			
			if (!previousState.keyEnter && currentState.keyEnter) {
				gameObject.handleMessage("reload");
			}
			
			if (!previousState.key2 && currentState.key2) {
				gameObject.handleMessage("buildTower");
			}
		}
		
	}

}