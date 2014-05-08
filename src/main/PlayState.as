package main 
{
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.StaticVars;
	import a_basic_theme.*;
	
	/**
	 * Default class for each level, holding common aspects such as timer and score
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
		
		private var max_time: Number;
		
		public var timer : FlxDelay;
		
		private var settingButton: SettingButton;
		
		/**
		 * contructor of PlayState
		 * 
		 * @param	max_score define the max score for the score bar
		 * @param max_time define the max time of a level in ms
		 */
		public function PlayState(max_score:Number, max_time:Number): void {
			super();
			this.max_score = max_score;
			this.max_time = max_time;
			timer = new FlxDelay(max_time);
			timer.start();
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
	
		public function end_level() :void {
			
		}
		
		public function checkScore():void {
			score = Math.max(0, Math.min(score, this.max_score));
		}
	}
}