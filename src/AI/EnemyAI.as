package AI 
{
	import flash.geom.Vector3D;
	import gameObjects.BasicTower;
	import gameObjects.EnemyBreadCrumbs;
	import gameObjects.InternalWall;
	import gameObjects.Pedestal;
	import nl.jorisdormans.phantom2D.core.Composite;
	import nl.jorisdormans.phantom2D.objects.GameObject;
	import nl.jorisdormans.phantom2D.objects.GameObjectComponent;
	import nl.jorisdormans.phantom2D.objects.Tile;
	import nl.jorisdormans.phantom2D.objects.TiledObjectLayer;
	
	/**
	 * ...
	 * @author RubenRodriguez
	 */
	public class EnemyAI extends GameObjectComponent 
	{
		
		private var pedestal:GameObject;
		
		private var tiledObjectLayer:TiledObjectLayer;
		
		private var actualTile:Tile;
		private var previousTile:Tile;
		
		public function EnemyAI() 
		{
			
		}
		
		override public function onAdd(composite:Composite):void 
		{
			super.onAdd(composite);
			if (!gameObject.mover) {
				throw new Error("The objects needs to a mover");
			}
			
		}
		
		override public function onInitialize():void 
		{
			super.onInitialize();
			tiledObjectLayer = gameObject.objectLayer as TiledObjectLayer;
			
			if (!tiledObjectLayer) {
				throw new Error("The object needs to be in a TiledObjectLayer");
			}
			
			actualTile = tiledObjectLayer.getTile(gameObject.position);
			
			pedestal = tiledObjectLayer.getObjectByClass(Pedestal);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			actualTile = tiledObjectLayer.getTile(gameObject.position);
			
			if(previousTile != actualTile){			
				
				/*[LEFT,UP,RIGHT,DOWN]*/
				var emptyTiles:Array = findEmptyTiles();
				
				var emptyPaths:Number = 0;
				
				for each(var i:Boolean in emptyTiles) {
					if (i) emptyPaths++;
				}
				
				if (emptyPaths == 1) {
					//Only 1 possible path
					go1Path(emptyTiles);
				}else if (emptyPaths == 2) {
					//2 possible paths, go for the one you have not come
					go2Path(emptyTiles);
				}else {
					//3 or more paths, AI acts
						IADetectPath(emptyTiles);
				}
			}
			
			previousTile = actualTile;
			
		}
		
		private function findEmptyTiles():Array {
			
			var result:Array = new Array(false,false,false,false);
			
			if (actualTile.left != null) {
				
				var empty:Boolean = true;
				
				for each(var go:GameObject in actualTile.left.objects) {
					if (go is BasicTower || go is InternalWall) {
						empty = empty && false;
					}
				}
				
				if (empty) {
					result[0] = true;
				}
				
			}
			
			if (actualTile.up != null) {
				
				var empty:Boolean = true;
				
				for each(var go:GameObject in actualTile.up.objects) {
					if (go is BasicTower || go is InternalWall) {
						empty = empty && false;
					}
				}
				
				if (empty) {
					result[1] = true;
				}
				
			}
			
			if (actualTile.right != null) {
				
				var empty:Boolean = true;
				
				for each(var go:GameObject in actualTile.right.objects) {
					if (go is BasicTower || go is InternalWall) {
						empty = empty && false;
					}
				}
				
				if (empty) {
					result[2] = true;
				}
				
			}
			
			if (actualTile.down != null) {
				
				var empty:Boolean = true;
				
				for each(var go:GameObject in actualTile.down.objects) {
					if (go is BasicTower || go is InternalWall) {
						empty = empty && false;
					}
				}
				
				if (empty) {
					result[3] = true;
				}
				
			}
			
			return result;
		}
		
		private function calculateLeftSmoke():Number {
			
			var tile:Tile = actualTile.left;
			var result:Number = 0;
			
			for each(var go:GameObject in tile.objects) {
				if (go is EnemyBreadCrumbs) {
					result += (go.getProperty("intensity") as Number);
				}
			}
			
			if (tile.left) {
				for each(var go:GameObject in tile.left.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.up) {
				for each(var go:GameObject in tile.up.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.down) {
				for each(var go:GameObject in tile.down.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			return result;
			
		}
		
		private function calculateUpSmoke():Number {
			
			var tile:Tile = actualTile.up;
			var result:Number = 0;
			
			for each(var go:GameObject in tile.objects) {
				if (go is EnemyBreadCrumbs) {
					result += (go.getProperty("intensity") as Number);
				}
			}
			
			if (tile.left) {
				for each(var go:GameObject in tile.left.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.up) {
				for each(var go:GameObject in tile.up.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.right) {
				for each(var go:GameObject in tile.right.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			return result;
			
		}
		
		private function calculateRightSmoke():Number {
			
			var tile:Tile = actualTile.right;
			var result:Number = 0;
			
			for each(var go:GameObject in tile.objects) {
				if (go is EnemyBreadCrumbs) {
					result += (go.getProperty("intensity") as Number);
				}
			}
			
			if (tile.right) {
				for each(var go:GameObject in tile.right.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.up) {
				for each(var go:GameObject in tile.up.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.down) {
				for each(var go:GameObject in tile.down.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			return result;
			
		}
		
		private function calculateDownSmoke():Number {
			
			var tile:Tile = actualTile.down;
			var result:Number = 0;
			
			for each(var go:GameObject in tile.objects) {
				if (go is EnemyBreadCrumbs) {
					result += (go.getProperty("intensity") as Number);
				}
			}
			
			if (tile.left) {
				for each(var go:GameObject in tile.left.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.right) {
				for each(var go:GameObject in tile.right.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			if (tile.down) {
				for each(var go:GameObject in tile.down.objects) {
					if (go is EnemyBreadCrumbs) {
						result += (go.getProperty("intensity") as Number) * 0.5;
					}
				}
			}
			
			return result;
			
		}
		
		private function go1Path(emptyTiles:Array):void {
			if (emptyTiles[0]) gameObject.handleMessage("goLeft");
			else if (emptyTiles[1]) gameObject.handleMessage("goUp");
			else if (emptyTiles[2]) gameObject.handleMessage("goRight");
			else gameObject.handleMessage("goDown");
		}
		
		private function go2Path(emptyTiles:Array):void {
			if (emptyTiles[0] && actualTile.left != previousTile) gameObject.handleMessage("goLeft");
			else if (emptyTiles[1] && actualTile.up != previousTile) gameObject.handleMessage("goUp");
			else if (emptyTiles[2] && actualTile.right != previousTile) gameObject.handleMessage("goRight");
			else gameObject.handleMessage("goDown");
		}

		private function IADetectPath(emptyTiles:Array):void {
			
			var leftSmoke:Number = 0;
			var upSmoke:Number = 0;
			var rightSmoke:Number = 0;
			var downSmoke:Number = 0;
			
			var distanceAdjust:Array = getDistanceAdjust();
			
			if (!previousTile) previousTile = tiledObjectLayer.getTile(new Vector3D());
			
			if (emptyTiles[0] && !(previousTile.getPosition().equals(actualTile.left.getPosition()))) 
				leftSmoke = calculateLeftSmoke();
			if (emptyTiles[1] && !(previousTile.getPosition().equals(actualTile.up.getPosition()))) 
				upSmoke = calculateUpSmoke();
			if (emptyTiles[2] && !(previousTile.getPosition().equals(actualTile.right.getPosition()))) 
				rightSmoke = calculateRightSmoke();
			if (emptyTiles[3] && !(previousTile.getPosition().equals(actualTile.down.getPosition()))) 
				downSmoke = calculateDownSmoke();
				
			leftSmoke -= distanceAdjust[0];
			upSmoke -= distanceAdjust[1];
			rightSmoke -= distanceAdjust[2];
			downSmoke -= distanceAdjust[3];
				
			var maxIntensity:Number = Math.max(leftSmoke, upSmoke, rightSmoke, downSmoke);
			var possiblePaths:Array = new Array(false, false, false, false);
			if (maxIntensity == leftSmoke) possiblePaths[0] = true;
			if (maxIntensity == upSmoke) possiblePaths[1] = true;
			if (maxIntensity == rightSmoke) possiblePaths[2] = true;
			if (maxIntensity == downSmoke) possiblePaths[3] = true;
			
			var numberPossiblePaths:Number = 0;
			
			for each(var i:Boolean in possiblePaths) {
				if (i) numberPossiblePaths++;
			}
			
			if (numberPossiblePaths == 1) {
				go1Path(possiblePaths);
			}else {
				
				var possibles:Vector.<String> = new Vector.<String>;
				
				if (possiblePaths[0]) possibles.push("left");
				if (possiblePaths[1]) possibles.push("up");
				if (possiblePaths[2]) possibles.push("right");
				if (possiblePaths[3]) possibles.push("down");
				
				var finalDestiny:Number = 0;
				
				switch(numberPossiblePaths) {
					case 2:
						finalDestiny = Math.round(Math.random());
						break;
					case 3:
						finalDestiny = Math.round(Math.random() * 2);
						break;
					case 4:
						finalDestiny = Math.round(Math.random() * 3);
						break;
				}
				
				var end:String = "";
				
				while (finalDestiny >= 0) {
					finalDestiny--;
					end = possibles.pop();
				}
				
				switch(end) {
					
					case "left":
						gameObject.handleMessage("goLeft");
						break;
					case "down":
						gameObject.handleMessage("goDown");
						break;
					case "up":
						gameObject.handleMessage("goUp");
						break;
					case "right":
						gameObject.handleMessage("goRight");
						break;
					
				}
				
			}
			
		}
	
		private function getDistanceAdjust():Array {
			
			var distanceAdjust:Array = new Array( 1000, 1000, 1000, 1000);
			var minDistance:Number = 10000;
			var temp:Number;
			if (actualTile.left) {
				trace("1:"+pedestal.position.subtract(actualTile.left.getPosition()).length);
				distanceAdjust[0] = pedestal.position.subtract(actualTile.left.getPosition()).length;
				if (distanceAdjust[0] < minDistance)
					minDistance = distanceAdjust[0];
			}
			if (actualTile.up) {
				trace("2:"+pedestal.position.subtract(actualTile.up.getPosition()).length);
				distanceAdjust[1] = pedestal.position.subtract(actualTile.up.getPosition()).length;
				if (distanceAdjust[1] < minDistance)
					minDistance = distanceAdjust[1];
			}
			if (actualTile.right) {
				trace("3:"+pedestal.position.subtract(actualTile.right.getPosition()).length);
				distanceAdjust[2] = pedestal.position.subtract(actualTile.right.getPosition()).length;
				if (distanceAdjust[2] < minDistance)
					minDistance = distanceAdjust[2];
			}
			if (actualTile.down) {
				trace("4:"+pedestal.position.subtract(actualTile.down.getPosition()).length);
				distanceAdjust[3] = pedestal.position.subtract(actualTile.down.getPosition()).length;
				if (distanceAdjust[3] < minDistance)
					minDistance = distanceAdjust[3];
			}
			
			distanceAdjust[0] = distanceAdjust[0] - minDistance;
			distanceAdjust[1] = distanceAdjust[1] - minDistance;
			distanceAdjust[2] = distanceAdjust[2] - minDistance;
			distanceAdjust[3] = distanceAdjust[3] - minDistance;
			
			return distanceAdjust;
			
		}
		
	}
}