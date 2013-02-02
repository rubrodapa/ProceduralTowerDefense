package  
{
	import Components.EnemySpawner;
	import Components.GameOverComponent;
	import Components.WinOverComponent;
	import flash.geom.Vector3D;
	import gameObjects.BasicTower;
	import gameObjects.InternalWall;
	import gameObjects.MegaEnemy;
	import gameObjects.Path;
	import gameObjects.Pedestal;
	import gameObjects.Player;
	import gameObjects.Walls;
	import nl.jorisdormans.phantom2D.ai.statemachines.StateMachine;
	import refactor.SfxrSound;
	import nl.jorisdormans.phantom2D.cameras.CameraEase;
	import nl.jorisdormans.phantom2D.cameras.FollowObject;
	import nl.jorisdormans.phantom2D.cameras.RestrictToLayer;
	import nl.jorisdormans.phantom2D.core.Screen;
	import nl.jorisdormans.phantom2D.layers.Background;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	import nl.jorisdormans.phantom2D.particles.ParticleLayer;
	import nl.jorisdormans.phantom2D.thirdparty.sfxr.SfxrSynth;
	import states.TutorialState;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class GameScreen extends Screen 
	{
		
		private var tiledObjectLayer:TiledObjectLayer;
		private var particleLayer:ParticleLayer; 
		private var player: GameObject;
		
		public function GameScreen() 
		{
			
			addComponent(new Background(0x1A80E6, 0x1A80E6, 0x1A80E6));
			
			tiledObjectLayer = new TiledObjectLayer(40, 20, 15, 4);
			
			player = new Player();
			tiledObjectLayer.addGameObjectSorted(player, new Vector3D(100, 305));
			
			tiledObjectLayer.createObjects([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
															1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
															[null, Walls, InternalWall, Path,Pedestal,BasicTower]);
															
			addComponent(tiledObjectLayer);
			addComponent(particleLayer = new ParticleLayer(800, 600, 10000));
			
			addComponent(new StateMachine(new TutorialState()));
			
			camera.addComponent(new FollowObject(player));
			camera.addComponent(new CameraEase());
			camera.addComponent(new RestrictToLayer(tiledObjectLayer));
			
			var sfxr:SfxrSynth = new SfxrSynth();
			sfxr.params.setSettingsString("0,,0.3813,,0.3892,0.2918,,0.4599,,,,,,0.156,,0.6574,,,1,,,,,0.86");
			sfxr.cacheSound();
			
			var sfxr2:SfxrSynth = new SfxrSynth();
			sfxr2.params.setSettingsString("0,,0.39,0.4532,0.3197,0.8973,,,,,,0.56,0.59,,-0.02,0.41,,,1,,,,,0.71");
			sfxr2.cacheSound();
			
			addComponent(new SfxrSound("changeState", sfxr));
			addComponent(new SfxrSound("win", sfxr2));
			
			addComponent(new HUD(player));
			addComponent(new GameOverComponent());
			addComponent(new WinOverComponent());
		}
		
	}

}