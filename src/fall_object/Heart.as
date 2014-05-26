package fall_object 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Adrian
	 */
	public class Heart extends FlxSprite {
		[Embed(source = '../../img/heart.png')] private static var heart:Class;
		
		public function Heart(x:Number, y:Number) {
			super(x, y);
			loadGraphic(heart, false, false, 50, 50);
			velocity.y = 250; // move down velocity
		}		
	}
}