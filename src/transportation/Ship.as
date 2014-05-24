package transportation 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import levels.Helper;
	/**
	 * 
	 * @author Adrian
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source = '../../img/truck.png')] private static var ship:Class;
		
		private static const moveSpeed:int = 200;
		//private var xCoord : int;
		//private var yCoord : int;
		public var numObjs:Number;
		
		
		public function Ship (x:Number, y:Number) {
			super(x, y);
			//xCoord = x;
			//yCoord = y;
			//maxVelocity.x = 200;
			//this.scoreBar = scoreBar;
			loadGraphic(ship, true, false, 120, 60);
			addAnimation("left", [0], 0, false);
			addAnimation("right", [1], 0, false);
			
			//velocity.x = moveSpeed;
		}	
		
		override public function update():void 
		{
			if (FlxG.keys.LEFT && x > 5) {
				play("left", false);
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 385) {
				play("right", false);
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}	
			super.update();
		}
		
		public function getX():int {
			return x;
		}
	}
}