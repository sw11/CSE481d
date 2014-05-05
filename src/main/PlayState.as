package main 
{
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.StaticVars;
	import easy_theme.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class PlayState extends FlxState {
		[Embed(source = '../../img/settings.png')] private var setting:Class;
		
		public var score: Number;
		
		protected var settingButton: SettingButton;
		protected var flxbar: FlxBar;
				
		override public function create():void {
			score = 0;
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			flxbar = new FlxBar(15, 130, FlxBar.FILL_BOTTOM_TO_TOP, 100, 495, this, "score", 0, 20, true);
			flxbar.color = 0x999999;
			flxbar.killOnEmpty = false;
			add(flxbar);
			settingButton = new SettingButton(setting, StaticVars.SETTING_BUTTON_X, StaticVars.SETTING_BUTTON_Y);
			add(settingButton);		
			
		}
	
		override public function update():void {

			super.update();
			
		}

	}
}