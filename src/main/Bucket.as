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
		
		public function Bucket (graphic:Class, x:Number, y:Number) {
			super(x, y);
			xCoord = x;
			yCoord = y;
			loadGraphic(graphic, true, true, 100, 100);
		}	
		
		override public function update():void 
		{
			super.update();
			 
			if (FlxG.keys.justPressed("RIGHT")) {
				if (x < 440) {
					x = xCoord + 100;
					xCoord = xCoord + 100;
					
				}
			
			} else if (FlxG.keys.justPressed("LEFT")) {
				if (x > 130) {				
					x = xCoord - 100;
					xCoord = xCoord - 100;
					
				}
			} 
		}
	}
}