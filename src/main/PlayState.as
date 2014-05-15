package main 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.*;
	import a_basic_theme.*;
	import fall_object.*;
	
	/**
	 * Default class for each level, holding common aspects such as timer and score
	 * 
	 * @author Sam Wilson
	 */
	public class PlayState extends FlxState {
		[Embed(source = '../../img/settings.png')] private var setting:Class;
		/** Keep track of current score*/
		public var score: Number;
		public var miss:int;
		
		/** Displays the score, keeps tract of "score"*/
		public var scoreBar: FlxBar;
		/** Max score of a level, used for defining score bar*/
		protected var maxScore:int;
		protected var passScore:int;
		
		private var max_time: Number;
		public var timer : FlxDelay;
		
		//private var settingButton: SettingButton;
		
		private var counter:int;
		private var maxCount:int;
		
		protected var lane:int;
		
		protected var remainingTimeDisplay:FlxText;
		
		// the current theme 
		protected var currectTheme:int;
		// the current level
		protected var level:int;
		
		protected var killBar:FlxSprite;
		protected var missCount:int;
		
		protected var _fallObj: FlxGroup;
		protected var _bombs: FlxGroup;
		
		/**
		 * contructor of PlayState
		 * 
		 * @param	max_score define the max score for the score bar
		 * @param max_time define the max time of a level in ms
		 */
		public function PlayState(max_time:Number): void {
			super();
			resetCount(StaticVars.a1Interval);
			missCount = 0;
			score = 0;
			this.max_time = max_time;
			timer = new FlxDelay(max_time);
			timer.start();
		}
				
		override public function create():void {
			
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			scoreBar = new FlxBar(15, 130, FlxBar.FILL_BOTTOM_TO_TOP, 100, 495, this, "score", 0, maxScore, true);
			scoreBar.color = 0x141BE3;
			scoreBar.createFilledBar(0x88141BE3, 0xFF14e32c, false, 0x00000000);
			scoreBar.killOnEmpty = false;
			
			add(scoreBar);
			
			var levelInstr2:FlxText;
			levelInstr2 = new FlxText(0, 16, FlxG.width, currectTheme + " theme\nLevel " + level + "\nEsc to main menu");
			levelInstr2.setFormat(null, 11, StaticVars.BLACK, "left");
			add(levelInstr2);
			
			//settingButton = new SettingButton(setting, StaticVars.SETTING_BUTTON_X, StaticVars.SETTING_BUTTON_Y);
			//add(settingButton);		
			
			killBar = new FlxSprite(130, 600);
			killBar.makeGraphic(500, 5, StaticVars.INVISIBLE);
			add(killBar);
			
			remainingTimeDisplay = new FlxText(0, 16, FlxG.width, ""+timer.secondsRemaining);
			remainingTimeDisplay.setFormat(null, 16, StaticVars.BLACK, "center");
			add(remainingTimeDisplay);
		}
	
		override public function update():void {
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(killBar, _bombs, overlapKillBarBomb);
			
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new ThemeState());
			}
			super.update();
			
			remainingTimeDisplay.text = "" + timer.secondsRemaining;
			checkScore();
			if (score >= maxScore) {
				scoreBar.color = 0xDEA543;
			}
		}
		
		protected function checkScore():void {
			score = Math.max(0, Math.min(score, maxScore));
		}
		
		protected function genRandom(interval:int):Boolean {
			if (counter++ > maxCount) {
				resetCount(interval);
				return true;
			} 
			return false;
		}
		
		protected function resetCount(interval:int):void {
			counter = 0;
			maxCount = Math.random() * 20 + interval;
		}
		
		protected function genLane(preLane:int):int {
			var lane:int;
			while ((lane = FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int) == preLane){}
			return lane;
		}
		
		protected function oneOf(num:int):Boolean {
			return randNum(num) == 1;
		}
		
		protected function randNum(num:int):int {
			return Math.round(Math.random() * num);
		}
		
		protected function endGame(level:int): void {
			if (score >= passScore) {
				State.nextLevel();
				FlxG.switchState(new EndState("WIN", score, miss));
			} else {
				FlxG.switchState(new EndState("LOSE", score, miss));	
			}
		}
		
		protected function overlapKillBarObj(killBar:FlxSprite, obj:FallingObj):void {
			obj.kill();
			miss++;
			if (missCount++ >= 5) {
				score--;
				missCount = 0;
			}
		}
		
		protected function  overlapKillBarBomb(killBar:FlxSprite, bomb:Bomb):void {
			bomb.kill();
		}
	}
}