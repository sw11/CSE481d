package fall_object 
{
	import org.flixel.FlxSprite;
	import utility.StaticVars;
	/**
	 * ...
	 * @author Adrian
	 */
	public class AmmoBox extends FlxSprite {
		[Embed(source = '../../img/ammobox.png')] private static var ammoBox:Class;
		
		public function AmmoBox(x:Number, y:Number) {
			super(x, y);
			loadGraphic(ammoBox, false, false, 50, 50);
			velocity.y = 250; // move down velocity
		}	
		
		/*override public function update():void {
			super.update();
			if (this.y > StaticVars.HEIGHT) {
				this.kill();
			}
		}*/
	}
}