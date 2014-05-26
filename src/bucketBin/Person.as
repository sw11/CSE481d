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
		[Embed(source = '../../img/car.png')] private static var person:Class;
		public var healthLeft:Number;
		
		public function Person (x:Number, y:Number) {
			super(x, y);
			loadGraphic(person, true, false, 50, 50);
			addAnimation("right", [1], 0, false);
			addAnimation("left", [0], 0, false);
		}	
		
		override public function update():void 
		{
			if (FlxG.keys.LEFT && x > 5){
				velocity.x = -StaticVars.speed;
				play("left", false);
			} else if (FlxG.keys.RIGHT && x < 455) {
				velocity.x = StaticVars.speed;
				play("right", false);
			} else {
				velocity.x = 0;
			}	
			super.update();
			//scoreBar.x = x;
		}
		
	}
}