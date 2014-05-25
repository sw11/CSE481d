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
		[Embed(source = '../../img/smallFish.png')] private static var fish:Class;
		public var healthLeft:Number;
		private var counter:int;
		private var maxCount:int;
		
		public function Fish(x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(fish, true, false, 70, 26);
			velocity.x = moveSpeed;
			addAnimation("right", [0], 0, false);
			addAnimation("left", [1], 0, false);
		}	
		
		override public function update():void 
		{
			//trace("fish update");
			if (x < 5) {
				play("right", false);
				velocity.x = moveSpeed;
				counter = 0;
			} else if (x > 440) {
				play("left", false);
				velocity.x = -moveSpeed;
				counter = 0;
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