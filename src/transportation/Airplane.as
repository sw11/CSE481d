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
	public class Airplane extends FlxSprite
	{
		[Embed(source = '../../img/airplane.png')] private static var airplane:Class;
		
		private static const moveSpeed:int = 250;
		//private var xCoord : int;
		//private var yCoord : int;
		public var numObjs:Number;
		
		private var counter:int;
		private var maxCount:int;
		
		public function Airplane (x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(airplane, true, false, 120, 60);
			addAnimation("left", [0], 0, false);
			addAnimation("right", [1], 0, false);
			//addAnimation("green", [1, 0], 10, false);
			//addAnimation("red", [2, 0], 3, false);
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
				maxCount = Math.floor(Math.random() * 30 + 40);
				///trace(velocity.x);
				velocity.x = -velocity.x; // StaticVars.speed * maxCount * ( -1);
				if (velocity.x > 0) {
					play("right", false);
				} else {
					play("left", false);
				}
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