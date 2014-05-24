package bucketBin 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Fish extends FlxSprite
	{
		//private static const _move_speed : int = 400;
		private static const moveSpeed:int = 200;
		//private var xCoord : int;
		//private var yCoord : int;
		//private var scoreBar:FlxBar;
		[Embed(source = '../../img/fallObjs/Fish.png')] private static var fish:Class;
		public var healthLeft:Number;
		private var counter:int;
		private var maxCount:int;
		
		public function Fish(x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(fish, true, false, 100, 50);
			velocity.x = moveSpeed;
			//addAnimation("left", [0], 0, false);
			//addAnimation("right", [1], 0, false);
		}	
		
		override public function update():void 
		{
			//trace("fish update");
			if (x < 5) {
				//play("right", false);
				velocity.x = moveSpeed;
				counter = 0;
			} else if (x > 405) {
				//play("left", false);
				velocity.x = -moveSpeed;
				counter = 0;
			} 
			/*else if (counter++ > maxCount) {
				
				counter = 0;
				maxCount = Math.floor(Math.random() * 50 + 50);
				///trace(velocity.x);
				velocity.x = -velocity.x; // StaticVars.speed * maxCount * ( -1);
				/*if (velocity.x > 0 ) {
					play("right", false);
				} else {
					play("left", false);
				}
			} */
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