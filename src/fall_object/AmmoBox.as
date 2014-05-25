package fall_object 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class AmmoBox extends FlxSprite {
		[Embed(source = '../../img/ammo-box.png')] private static var ammoBox:Class;
		
		public function AmmoBox(x:Number, y:Number) {
			super(x, y);
			loadGraphic(ammoBox, false, false, 75, 75);
			velocity.y = -250; // move down velocity
		}		
	}
}