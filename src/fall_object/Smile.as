package fall_object 
{
	import org.flixel.FlxSprite;
	import utility.StaticVars;
	
	/**
	 * This class is a smiley face that provides feedback to the user when
	 * the fish is happy
	 * 
	 * Automatically kills itself when outside screen
	 * 
	 * @author Adrian
	 */
	public class Smile extends FlxSprite {
		[Embed(source = '../../img/smile.png')] private static var smile:Class;
		
		public function Smile(x:Number, y:Number, left:Boolean) {
			super(x, y);
			loadGraphic(smile, false , false, 25, 25);
			velocity.x = left ? -100 : 100;
			velocity.y = -100;
			this.acceleration.y = 200; 
		}
		
		override public function update():void {			
			super.update();
			if (this.x > StaticVars.WIDTH || this.y > StaticVars.HEIGHT) {
				this.kill();
				//trace("star killed");
			}
			alpha -= StaticVars.STAR_ALPHA;
		}
	}

}