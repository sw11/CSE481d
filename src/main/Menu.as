package main 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Menu extends FlxSprite
	{
		
		
		public function Menu(x:int, y:int, w:int, h:int, graphic:Class) 
		{
			super(x, y);
			loadGraphic(graphic, true, true, w, h);
			

		}
		
		/*override public function update():void {
			if (FlxG.keys.p) {
				// go to play state
			} else if (FlxG.key.s) {
				// go to setting state
			}
		}*/
	}

}