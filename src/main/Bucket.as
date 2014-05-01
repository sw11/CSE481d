package main 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Bucket extends FlxSprite
	{
		
		private var xCoord : int;
		private var yCoord : int;
		private var depressed : Boolean;
		
		public function Bucket (graphic:Class, x:Number, y:Number) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			loadGraphic(graphic, true, true, 100, 100);
			depressed = false;
		}	
		
		override public function update():void 
		{
			 super.update();
			 if (FlxG.keys.RIGHT && !depressed) {
				if (x < 440) {
					x = xCoord + 100;
					xCoord = xCoord + 100;
					depressed = true
				}
			} else if (FlxG.keys.LEFT && ! depressed) {
				if (x > 130) {				
					x = xCoord - 100;
					xCoord = xCoord - 100;
					depressed = true;
				}
			} else if (!FlxG.keys.LEFT && !FlxG.keys.RIGHT) {
				depressed = false;
			}
		}
		
	}

}