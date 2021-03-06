package bucketBin 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Shark extends FlxSprite
	{
		//private static const _move_speed : int = 400;
		private var moveSpeed:int;
		private static const ySpeed:int = 50;
		//private var xCoord : int;
		//private var yCoord : int;
		//private var scoreBar:FlxBar;
		[Embed(source = '../../img/shark-1.png')] private static var shark:Class;
		//public var healthLeft:Number;
		private var counter:int;
		private var maxCount:int;
		private var rand:int;
		// y
		private var yCounter:int;
		private var yMaxCount:int;
		private var up:int;
		private var down:int;
		
		public function Shark(x:Number, y:Number, up:int, down:int, rand:int, speed:int) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			moveSpeed = speed;
			loadGraphic(shark, true, false, 75, 50);
			velocity.x = moveSpeed;
			velocity.y = ySpeed;
			this.up = up;
			this.down = down;
			this.rand = rand;
			offset = new FlxPoint(0, 25);
			addAnimation("right", [0], 0, false);
			addAnimation("left", [1], 0, false);
			//addAnimation("left", [0], 0, false);
			//addAnimation("right", [1], 0, false);
		}	
		
		override public function update():void 
		{
			if (x < 5) {
				play("right", false);
				velocity.x = moveSpeed;
				counter = 0;
			} else if (x > 405) {
				play("left", false);
				velocity.x = -moveSpeed;
				counter = 0;
			} else if (counter++ > maxCount) {
				
				counter = 0;
				maxCount = Math.floor(Math.random() * rand + rand);
				///trace(velocity.x);
				velocity.x = -velocity.x; // StaticVars.speed * maxCount * ( -1);
				if (velocity.x > 0 ) {
					play("right", false);
				} else {
					play("left", false);
				}
			} 
			
			if (y < up) {
				velocity.y = ySpeed;
			} else if (y > down) {
				velocity.y = -ySpeed;
			} else if (yCounter++ > yMaxCount) {
				yCounter = 0;
				yMaxCount = Math.floor(Math.random() * 15 + 20);
				///trace(velocity.x);
				velocity.y = -velocity.y;
			}
			super.update();
			//scoreBar.x = x;
		}
		
		/*public function moveBucket():void {
			//trace("inside bucket");
			if (FlxG.keys.LEFT && x > 5){
				x -= 10;
			} else if (FlxG.keys.RIGHT && x < 405) {
				x += 10;
			} 
			/*else {
				velocity.x = 0;
			}
		}*/
	}
}