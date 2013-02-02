package  gameObjects
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BombsThrower;
	import GameObjectComponents.ButtonsHandler;
	import GameObjectComponents.Energy;
	import GameObjectComponents.FinalExplosion;
	import GameObjectComponents.TowerBuilder;
	import refactor.SfxrSound;
	import nl.jorisdormans.phantom2D.objects.boundaries.CollideWithLayerEdge;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.misc.ArrowKeyHandler;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingCircle;
	import nl.jorisdormans.phantom2D.particles.ParticleEmitter;
	import nl.jorisdormans.phantom2D.particles.Particle;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class Player extends GameObject 
	{
		
		public function Player() 
		{
			var sfxr:SfxrSynth = new SfxrSynth();
			sfxr.params.setSettingsString("0,,0.1279,,0.1397,0.2036,,,,,,,,0.373,,,,,1,,,0.1,,0.86");
			sfxr.cacheSound();
			
			addComponent(new BoundingCircle(10));
			addComponent(new BoundingShapeRenderer(0xffdd00));
			addComponent(new Mover(new Vector3D(), 2, 0.5));
			addComponent(new ArrowKeyHandler(1200));
			addComponent(new CollideWithLayerEdge());
			addComponent(new ButtonsHandler());
			addComponent(new BombsThrower());
			addComponent(new TowerBuilder());
			addComponent(new Energy(50, 100));
			addComponent(new SfxrSound("errorBip", sfxr));
			addComponent(new FinalExplosion());
		}
		
		override public function canCollideWith(other:GameObject):Boolean 
		{
			if (other is InternalWall || other is BasicTower) {
				return false;
			}
			
			return super.canCollideWith(other);
		}
		
	}

}