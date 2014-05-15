package fall_object 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Bomb extends FlxSprite
	{
		
		/*Check if kill has already been called on this object*/
		public var killed : Boolean;
		[Embed(source = '../../img/bombWithExp.png')] private var bomb:Class;
		public function Bomb(x:Number, y:Number) 
		{
			super(x, y);
			loadGraphic(bomb, true, false, 100, 100);
			velocity.y = 250; // move down velocity
			this.offset = new FlxPoint(0, -25);
			addAnimation("explosion", [0, 1], 120, false);
			killed = false;
		}
		
		override public function kill():void {
			killed = true;
			super.kill();
			exists = true;
			velocity.x = 0;
			velocity.y = 0;
			
			play("explosion");
			var deadTimer:FlxTimer = new FlxTimer() ;
			deadTimer.start (0.2, 1, onDeadTimeout) ;
		}
		
		private function onDeadTimeout (timer:FlxTimer):void {
			timer.stop();
			exists = false;
		}
	}
}