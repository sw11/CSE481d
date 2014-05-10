package main 
{
	import b_recycle_theme.*;
	import org.flixel.*;
	import a_basic_theme.*;
	import utility.StaticVars;
	import d_bomb_theme.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = '../../img/play_button.png')] private var playButton:Class;
		[Embed(source = '../../img/setting_button.png')] private var settingButton:Class;
		
		private var play:Menu;
		private var setting:Menu;
		
		override public function create():void {
			FlxG.bgColor = StaticVars.WHITE;
			
			// play button
			play = new Menu(StaticVars.PLAY_BTN_X, StaticVars.PLAY_BTN_y, StaticVars.PLAY_W, StaticVars.PLAY_H, playButton);
			add(play);
			
			// setting button
			setting = new Menu(StaticVars.SETTING_BTN_X, StaticVars.SETTING_BTN_y, StaticVars.SETTING_W, StaticVars.SETTING_H, settingButton);
			add(setting);
			
			var winnerText:FlxText;
			winnerText = new FlxText(0, 16, FlxG.width, "Press enter to start");
			winnerText.setFormat(null, 16, 0x11111111, "center");
			add(winnerText);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.P || FlxG.keys.justPressed("ENTER")) {
				FlxG.switchState(new ALevel3());
			} else if (FlxG.keys.S) {
				FlxG.switchState(new SettingState());
			} else {
				return;
			}
		}
		
	}

}