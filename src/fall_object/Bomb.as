package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Bomb extends FlxSprite
	{
		[Embed(source = '../../img/bomb.png')] private var bomb:Class;
		public function Bomb(x:Number, y:Number) 
		{
			super(x, y);
			loadGraphic(bomb, true, true, 50, 50);
			velocity.y = 250; // move down velocity
		}
		
	}

}