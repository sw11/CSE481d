package bucketBin 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Tank extends FlxSprite
	{
		//private static const _move_speed : int = 400;
		//private var xCoord : int;
		//private var yCoord : int;
		//private var scoreBar:FlxBar;
		[Embed(source = '../../img/tank.png')] private static var tank:Class;
		public var healthLeft:Number;
		
		public function Tank (x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(tank, true, false, 100, 50);
			addAnimation("right", [0], 0, false);
			addAnimation("left", [1], 0, false);
		}	
		
		override public function update():void 
		{
			//trace("inside bucket");
			//moveBucket();
			
			if (FlxG.keys.LEFT && x > 5){
				velocity.x = -StaticVars.speed;
				play("left", false);
			} else if (FlxG.keys.RIGHT && x < 405) {
				velocity.x = StaticVars.speed;
				play("right", false);
			} else {
				velocity.x = 0;
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