package gameObjects 
{
	import flash.geom.Vector3D;
	import GameObjectComponents.BehaviourComponents.PlayerEvade;
	import GameObjectComponents.BoundingCircleSmaller;
	import GameObjectComponents.LifeTime;
	import refactor.SfxrSound;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.Mover;
	import nl.jorisdormans.phantom2D.objects.renderers.BoundingShapeRenderer;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingBoxAA;
	import nl.jorisdormans.phantom2D.objects.shapes.BoundingPolygon;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class PickUp extends GameObject 
	{
		
		private var sfxr:SfxrSynth;
		
		public function PickUp() 
		{
			sfxr = new SfxrSynth();
			sfxr.params.setSettingsString("0,,0.0174,0.5774,0.3218,0.705,,,,,,0.5592,0.5133,,,,,,1,,,,,0.78");
			sfxr.cacheSound();
			
			addComponent(new BoundingPolygon(new Vector3D(0, -18), new Vector3D(9, 0), new Vector3D(-9, 0)));
			addComponent(new BoundingShapeRenderer(0xFF8900));
			addComponent(new Mover(new Vector3D(0, -100), 0, 0));
			addComponent(new PlayerEvade());
			addComponent(new LifeTime(5, true));
			addComponent(new SfxrSound("collected", sfxr));
		}
		
		override public function canCollideWith(other:GameObject):Boolean 
		{
			if (other is InternalWall) {
				return false;
			}
			
			return super.canCollideWith(other);
		}
		
		override public function afterCollisionWith(other:GameObject):void 
		{
			if (other as Player) {
				other.handleMessage("incrementEnergy",25);
				this.handleMessage("collected");
				this.destroyed = true;
			}
			super.afterCollisionWith(other);
		}
	}

}