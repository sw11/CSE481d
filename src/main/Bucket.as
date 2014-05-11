package main 
{
	import org.flixel.*;
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
			loadGraphic(graphic, true, true, 100, 100);
		}	
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.LEFT && x > 130){
				velocity.x = -_move_speed ;
			} else if (FlxG.keys.RIGHT && x < 540) {
				velocity.x = _move_speed ;
			} else {
				velocity.x = 0;
			}	
		}
	}
}