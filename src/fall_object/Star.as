package fall_object 
{
	import org.flixel.FlxSprite;
	import utility.StaticVars;
	
	/**
	 * This class is a smiling star that provides feedback to the user when
	 * the user collects the correct item.
	 * 
	 * Automatically kills itself when outside screen
	 * 
	 * @author Adrian
	 */
	public class Star extends FlxSprite {
		[Embed(source = '../../img/star-smile.png')] private static var star:Class;
		
		public function Star(x:Number, y:Number) {
			super(x + 50, y + 50);
			loadGraphic(star, false , false, 50, 50);
			velocity.x = 100;
			velocity.y = -100;
			this.acceleration.y = 200; 
		}
		
		override public function update():void {			
			super.update();
			if (this.x > StaticVars.WIDTH || this.y > StaticVars.HEIGHT) {
				this.kill();
				//trace("star killed");
			}
		}
	}
}