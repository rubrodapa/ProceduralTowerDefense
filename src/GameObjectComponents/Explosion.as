package GameObjectComponents 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.core.Phantom;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Explosion extends GameObjectComponent 
	{
		
		public var destroy:Boolean;
		public var color:Number;
		private var sfx:SfxrSynth;
		
		public function Explosion(destroy:Boolean = true,color:Number = 0xffffff) 
		{
			this.destroy = destroy;
			this.color = color;
			sfx = new SfxrSynth();
			sfx.params.setSettingsString("3,,0.3148,0.7322,0.0431,0.0761,,0.0682,,,,0.3077,0.7654,,,,,,1,,,,,0.5");
			sfx.cacheSound();
		}
		
		override public function handleMessage(message:String, data:Object = null, componentClass:Class = null):int 
		{
			switch(message) {
			
				case "explode":
					explode();
					if (destroy) gameObject.destroyed = true;
					return Phantom.MESSAGE_HANDLED;
				break;
				default:
				
			}
			
			return super.handleMessage(message, data, componentClass);
		}
		
		private function explode():void {
			
			var particleLayer:ParticleLayer = gameObject.objectLayer.screen.getComponentByClass(ParticleLayer) as ParticleLayer;
			if (!particleLayer) {
				trace("WARNING: ParticleLayer not found for " + gameObject.toString());
				return;
			}
			
			sfx.play();
			
			var angle:Number = 0;
			while (angle < Math.PI * 2) {
				angle += Math.random() * 0.15 + 0.15;
				
				var particle:Particle = new Particle(color);
				
				var life:Number = 0.5 + (Math.random() - Math.random()) * 0.3;
				
				var speed:Number = 200 + (Math.random() - Math.random()) * 100;
				var velocity:Vector3D = new Vector3D();
				if (gameObject.mover) {
					velocity.x += gameObject.mover.velocity.x;
					velocity.y += gameObject.mover.velocity.y;
				}
				velocity.x += Math.cos(angle) * speed;
				velocity.y += Math.sin(angle) * speed;
				
				var position:Vector3D = gameObject.position.clone();
				position.x += Math.cos(angle) * speed * 0.05;
				position.y += Math.sin(angle) * speed * 0.05;
				
				particle.initialize(life, position, velocity);
				particleLayer.addParticle(particle);
			}
			
		}
	}

}