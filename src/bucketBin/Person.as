package bucketBin 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Person extends FlxSprite
	{
		[Embed(source = '../../img/GarbageBin.png')] private static var person:Class;
		public var healthLeft:Number;
		
		public function Person (x:Number, y:Number) {
			super(x, y);
			loadGraphic(person, true, false, 50, 50);
			addAnimation("green", [1, 0], 10, false);
			addAnimation("red", [2, 0], 3, false);
		}	
		
		override public function update():void 
		{
			if (FlxG.keys.LEFT && x > 5){
				velocity.x = -StaticVars.speed;
			} else if (FlxG.keys.RIGHT && x < 455) {
				velocity.x = StaticVars.speed;
			} else {
				velocity.x = 0;
			}	
			super.update();
			//scoreBar.x = x;
		}
		
	}
}