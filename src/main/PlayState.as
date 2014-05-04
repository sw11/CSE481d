package main 
{
	
	import org.flixel.*;
	import utility.StaticVars;
	import easy_theme.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class PlayState extends FlxState {
		[Embed(source = '../../img/settings.png')] private var setting:Class;
		
		
		private var bar: ScoreBar;
		private var settingButton: SettingButton;
		//private var _fallObj: FlxGroup;
				
		override public function create():void {
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			//_fallObj = new FlxGroup();
			//add(_fallObj);
			
			bar = new ScoreBar();
			add(bar);
			
			settingButton = new SettingButton(setting, StaticVars.SETTING_BUTTON_X, StaticVars.SETTING_BUTTON_Y);
			add(settingButton);		
		}
	
		override public function update():void {

			super.update();
		}

	}
}