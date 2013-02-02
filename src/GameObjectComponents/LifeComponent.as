package GameObjectComponents 
{
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class LifeComponent extends GameObjectComponent 
	{
		
		private var render:BoundingShapeRenderer;
		private var life:Number;
		private var colorful:Boolean;
		private var middleLife:Number;
		private var divisions:Number;
		private var color:uint;
		
		public function LifeComponent(life:Number = 3, colorful:Boolean = true) 
		{
			this.life = life;
			this.colorful = colorful;
		}
		
		override public function onInitialize():void 
		{
			render = gameObject.getComponentByClass(BoundingShapeRenderer) as BoundingShapeRenderer;
			if (!render) trace("The gameObject needs a ShapeRenderer");
			
			middleLife = Math.ceil(life / 2);
			divisions = Math.floor(life / 2);
			if(colorful)
				color = 0x00FF00;
			
			super.onInitialize();
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
				case "damage":
					decreaseLife();
					return Phantom.MESSAGE_HANDLED;
					break;
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function getProperty(property:String, data:Object = null, componentClass:Class = null):Object 
		{
			switch(property) {
				case "life":
					return life;
			}
			return super.getProperty(property, data, componentClass);
		}
		
		public function decreaseLife():void {
			
			life--;
			if(colorful){
				if (life > middleLife) {
					render.fillColor += (255 / divisions) * Math.pow(2,16);
				}else if (life == middleLife) {
					render.fillColor = 0xFFFF00;
				}else {
					render.fillColor -= (255 / divisions) * Math.pow(2,8);
				}
			}
			
			if (life <= 0) {
				gameObject.handleMessage("explode");
				if (gameObject is Pedestal) {
					gameObject.objectLayer.parent.handleMessage("gameOver");
				}
			}
			
		}
		
	}

}