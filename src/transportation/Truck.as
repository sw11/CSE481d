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
		[Embed(source = '../../img/fallObjs/microwave.png')] private static var truck:Class;
		
		private static const moveSpeed:int = 200;
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
			loadGraphic(truck, true, false, 100, 100);
			//addAnimation("green", [1, 0], 10, false);
			//addAnimation("red", [2, 0], 3, false);
			velocity.x = moveSpeed;
		}	
		
		override public function update():void 
		{
			super.update();
			// need random walk
			if (x < 5) {
				velocity.x = moveSpeed;
				counter = 0;
			} else if (x > 405) {
				velocity.x = -moveSpeed;
				counter = 0;
			} else if (counter++ > maxCount) {
				counter = 0;
				maxCount = Math.floor(Math.random() * 50 + 50);
				///trace(velocity.x);
				velocity.x = -velocity.x; // StaticVars.speed * maxCount * ( -1);
			} 
			/*
			if (Helper.oneOf(2) && x > 5) {
				
			} else if (x < 505) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}*/
			
			/*if (FlxG.keys.LEFT && x > 5){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 505) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}	*/
			//scoreBar.velocity.x = velocity.x;
		}
		
		public function getX():int {
			return x;
		}
	}
}