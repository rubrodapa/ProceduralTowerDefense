package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BoundingCircleSmaller;
	import GameObjectComponents.Explosion;
	import nl.jorisdormans.phantom2D.audio.SfxrSound;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Bomb extends GameObject 
	{
		
		private var detectExplosion:Boolean = false;
		
		public function Bomb() 
		{	
			addComponent(new BoundingCircle(10));
			addComponent(new BoundingShapeRenderer(0xffffff, 0x000000, 3));
			addComponent(new BoundingCircleSmaller());
			addComponent(new Mover(new Vector3D()));
			addComponent(new Explosion(true, 0xffffff));
			doResponse = false;
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if(detectExplosion){
				
				if (other as InternalWall) other.handleMessage("explode");
				
			}
			
			super.afterCollisionWith(other);
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			if (message == "bombExplosion") {
				detectExplosion = true;
			}
				
			return super.handleMessage(message, data, componentClass);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			if (detectExplosion) {
				this.handleMessage("explode");
			}
			
			super.update(elapsedTime);
		}
		
	}

}