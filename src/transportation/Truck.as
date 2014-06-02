package transportation 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import levels.Helper;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Truck extends FlxSprite
	{
		[Embed(source = '../../img/truck.png')] private static var truck:Class;
		
		private static const moveSpeed:int = 250;
		//private var xCoord : int;
		//private var yCoord : int;
		public var numObjs:Number;
		
		private var counter:int;
		private var maxCount:int;
		
		public function Truck (x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(truck, true, false, 120, 60);
			addAnimation("left", [0], 0, false);
			addAnimation("right", [1], 0, false);
			
			velocity.x = moveSpeed;
		}	
		
		override public function update():void 
		{
			super.update();
			// need random walk
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
				maxCount = Math.floor(Math.random() * 50 + 60);
				///trace(velocity.x);
				velocity.x = -velocity.x; // StaticVars.speed * maxCount * ( -1);
				if (velocity.x > 0 ) {
					play("right", false);
				} else {
					play("left", false);
				}
			} 
		}
		
		public function getX():int {
			return x;
		}
	}
}