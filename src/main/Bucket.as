package main 
{
	import org.flixel.*;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Bucket extends FlxSprite
	{
		private static const _move_speed : int = 400;
		private var xCoord : int;
		private var yCoord : int;
		
		public function Bucket (graphic:Class, x:Number, y:Number) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			maxVelocity.x = 200;
			loadGraphic(graphic, true, false, 100, 50);
			addAnimation("green", [1, 0], 3, false);
			addAnimation("red", [2, 0], 2, false);
		}	
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.LEFT && x > 130){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 540) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}	
		}
	}
}