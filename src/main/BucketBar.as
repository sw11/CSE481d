package main 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class BucketBar extends FlxSprite
	{
		//private static const _move_speed : int = 400;
		//private var xCoord : int;
		//private var yCoord : int;
		//private var scoreBar:FlxBar;
		//[Embed(source = '../../img/GarbageBin.png')] private static var garbage:Class;
		public var healthLeft:Number;
		
		public function BucketBar (graphic:Class, x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(graphic, true, false, 100, 50);
			addAnimation("green", [1, 0], 10, false);
			addAnimation("red", [2, 0], 3, false);
			

		}	
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.LEFT && x > 5){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 405) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}	
			//scoreBar.x = x;
		}
	}
}