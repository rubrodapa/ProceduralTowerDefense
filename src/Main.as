package 
{
	import nl.jorisdormans.phantom2D.core.PhantomGame;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Main extends PhantomGame
	{
		
		public function Main():void 
		{
			super(800, 600);
			addScreen(new GameScreen());
		}
		
	}
	
}