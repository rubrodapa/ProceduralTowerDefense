package  
{
	import nl.jorisdormans.phantom2D.cameras.Camera
	import nl.jorisdormans.phantom2D.core.Layer;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class HUD extends Layer 
	{
		
		private var player:GameObject;
		
		public function HUD(player:GameObject) 
		{
			this.player = player;
		}
		
		override public function render(camera:Camera):void 
		{
			super.render(camera);
			var energyLevel:Number = 0;
			if (player)
			{
				energyLevel = player.getProperty("energyLevel") as Number;
			}
			
			this.sprite.graphics.lineStyle(1, 0xffffff);
			this.sprite.graphics.drawRect(10, 10, 200, 20);
			this.sprite.graphics.lineStyle(1, 0xffff00);
			this.sprite.graphics.beginFill(0xFF8000);
			this.sprite.graphics.drawRect(12, 12, 196 * energyLevel, 16);
			this.sprite.graphics.endFill();
			this.sprite.graphics.lineStyle();
		}
		
	}

}