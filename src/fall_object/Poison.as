package fall_object 
{
	import org.flixel.FlxSprite;
	import utility.StaticVars;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Poison extends FlxSprite {
		[Embed(source = '../../img/skull.png')] private static var skull:Class;
		
		public function Poison(x:Number, y:Number) {
			super(x, y);
			loadGraphic(skull, false, false, 50, 50);
			velocity.y = 250; // move down velocity
		}	
		
		override function update():void {
			if (y > StaticVars.HEIGHT) {
				this.kill();
			}
		}
	}
}