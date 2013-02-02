package refactor 
{
	import flash.geom.Vector3D;
	import nl.jorisdormans.phantom2D.particles.Particle;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class colorParticle extends Particle 
	{
		
		public function colorParticle(c:Number) 
		{
			this.color = c;
		}
		
		override public function initialize(life:Number, position:Vector3D, velocity:Vector3D):void 
		{
			living = 0;
			this.life = life;
			this.position = position;
			this.velocity = velocity;
		}
		
	}

}