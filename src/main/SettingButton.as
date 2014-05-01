package main 
{
	import org.flixel.FlxSprite;
	import utility.StaticVars;
	/**
	 * ...
	 * @author Adrian
	 */
	public class SettingButton extends FlxSprite
	{
		
		public function SettingButton(graphic:Class, x:Number, y:Number) {
			super(x, y);
			loadGraphic(graphic, true, true, StaticVars.SETTING_SIZE_X, StaticVars.SETTING_SIZE_Y);
		}
		
	}

}