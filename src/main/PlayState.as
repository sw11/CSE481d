package main 
{
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.StaticVars;
	import easy_theme.*;
	
	/**
	 * Default class for each level
	 * 
	 * @author Sam Wilson
	 */
	public class PlayState extends FlxState {
		[Embed(source = '../../img/settings.png')] private var setting:Class;
		/** Keep track of current score*/
		public var score: Number;
			
		/** Displays the score, keeps tract of "score"*/
		public var scoreBar: FlxBar;
		/** Max score of a level, used for defining score bar*/
		public var max_score: Number;
		
		
		
		
		
		private var settingButton: SettingButton;
		
		/**
		 * contructor of PlayState
		 * 
		 * @param	max_score define the max score for the score bar
		 */
		public function PlayState(max_score:Number): void {
			super();
			this.max_score = max_score;
			
		}
				
		override public function create():void {
			score = 0;
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			scoreBar = new FlxBar(15, 130, FlxBar.FILL_BOTTOM_TO_TOP, 100, 495, this, "score", 0, max_score, true);
			
			scoreBar.color = 0x999999;
			scoreBar.killOnEmpty = false;
			add(scoreBar);
			settingButton = new SettingButton(setting, StaticVars.SETTING_BUTTON_X, StaticVars.SETTING_BUTTON_Y);
			add(settingButton);		
		}
	
		override public function update():void {
			super.update();
		}
	}
}