package a_basic_theme 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.*;
	import a_basic_theme.*;
	import fall_object.*;
	import main.*;
	
	/**
	 * Default class for each level, holding common aspects such as timer and score
	 * 
	 * @author Sam Wilson
	 */
	public class APlayState extends FlxState {
		//[Embed(source = '../../img/settings.png')] private var setting:Class;
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
		//private var isDisplay:Boolean;
		
		// the current theme 
		//protected var currectTheme:int;
		// the current level that show on the screen
		protected var level:int;
		
		protected var killBar:FlxSprite;
		protected var missCount:int;
		
		protected var _fallObj: FlxGroup;
		protected var _bombs: FlxGroup;
		
		private var scoreText:FlxText;
		protected var isMaxScore:Boolean;
		protected var bonus:int;
		protected var isStart:Boolean;
		
		protected var bombScore:int;
		
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		protected var instr:FlxText;
		protected var instrStr:String;
		
		protected var passText:FlxText;
		protected var perfectText:FlxText;
		
		/**
		 * contructor of PlayState
		 * 
		 * @param	max_score define the max score for the score bar
		 * @param max_time define the max time of a level in ms
		 */
		public function APlayState(max_time:Number): void {
			super();
			resetCount(StaticVars.a1Interval);
			missCount = 0;
			score = 0;
			this.max_time = max_time;
			timer = new FlxDelay(max_time);
			passText = null;
			perfectText = null;
		}
				
		override public function create():void {
			paused = true;
			pauseGroup = new FlxGroup();
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			scoreBar = new FlxBar(15, 130, FlxBar.FILL_BOTTOM_TO_TOP, 100, 495, this, "score", 0, maxScore, true);
			scoreBar.color = 0x141BE3;
			scoreBar.createFilledBar(0x88141BE3, 0xFF14e32c, false, 0x00000000);
			scoreBar.killOnEmpty = false;
			
			add(scoreBar);
			
			var levelInstr2:FlxText;
			levelInstr2 = new FlxText(0, 16, FlxG.width, "Level " + level + "\nEsc to main menu");
			levelInstr2.setFormat(null, 11, StaticVars.BLACK, "left");
			add(levelInstr2);
			
			remainingTimeDisplay = new FlxText(0, 76, FlxG.width, "Time: "+ max_time/1000);
			remainingTimeDisplay.setFormat(null, 11, StaticVars.BLACK, "left");
			add(remainingTimeDisplay);
			
			scoreText = new FlxText(0, 96, FlxG.width, "Score: " + score + "\nMiss: " + miss);
			scoreText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(scoreText);

			killBar = new FlxSprite(130, 620);
			killBar.makeGraphic(500, 5, StaticVars.INVISIBLE);
			add(killBar);
			
			instr = new FlxText(StaticVars.WIDTH/2 - FlxG.width/2, 250, FlxG.width, instrStr);
			instr.setFormat(null, 30, StaticVars.BLACK, "center");
			add(instr);
		}
	
		override public function update():void {
			
			fadeText();
			
			if (paused && FlxG.keys.justPressed("ENTER")) {
				paused = !paused;
				instr.kill();
				timer.start();
			} else if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new ThemeState());
			}
			
			if (paused) {
				return pauseGroup.update();
			}
				
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(killBar, _bombs, overlapKillBarBomb);
			
			
			super.update();
			
			//if (timer.secondsRemaining <= 10 && !isDisplay) {
			//	add(remainingTimeDisplay);
			//	isDisplay = true;
			//}
			
			checkScore();
			scoreText.text = "Score: " + score + "\nMiss: " + miss;
			remainingTimeDisplay.text = "Time: " + Math.max(0, timer.secondsRemaining);
			if (timer.secondsRemaining <= 5) {
				remainingTimeDisplay.color = StaticVars.RED;
			}
			
			if (isMaxScore) {
				//trace("Max");
				scoreBar.color = StaticVars.YELLOW; // todo, won't work
				if (perfectText == null) {
					perfectText = new FlxText(0, 0, FlxG.width, "Perfect score!");
					perfectText.setFormat(null, 32, 0x11111111, "center");
					add(perfectText);
				}
			} else if (score >= passScore) {
				//trace("pass");
				scoreBar.color = StaticVars.GREEN;
				if (passText == null) {
					passText = new FlxText(0, 0, FlxG.width, "Passed!");
					passText.setFormat(null, 32, 0x11111111, "center");
					add(passText);
				}				
			} else {
				scoreBar.color = StaticVars.BLACK; // todo , change this color
			}
		}
		
		protected function fadeText(): void {
			if (perfectText != null) {
				perfectText.alpha = perfectText.alpha - 0.005;
				if (perfectText.alpha <= 0 ) {
					perfectText.kill();
					//perfectText = null;
				}
			}
			if (passText != null) {
				passText.alpha = passText.alpha - 0.005;
				if (passText.alpha <= 0) {
					passText.kill();
					//passText = null;
				}
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
			//var perfect:Number = maxScore * StaticVars.aPerf;
			if (score >= passScore) {
				//trace("in end game() theme " + StaticVars.A_THEME + " level " + level);
				if (level == State.unlockLevel) {
					State.nextLevel();
				}
				FlxG.switchState(new EndState("WIN", score, miss, bonus, maxScore, StaticVars.A_THEME, level));
			} else {
				FlxG.switchState(new EndState("LOSE", score, miss, bonus, maxScore, StaticVars.A_THEME, level));	
			}
		}
		
		protected function overlapKillBarObj(killBar:FlxSprite, obj:FallingObj):void {
			obj.kill();
			miss++;
			if (!isMaxScore && missCount++ > 5) {
				score--;
				missCount = 0;
			}
		}
		
		protected function overlapKillBarBomb(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill())
				bomb.kill();
		}
		
		protected function fallObject(yOffset:int, speed:int):void {
			var obj:FallingObj = new FallingObj(lane, yOffset);
			obj.velocity.y = speed;
			_fallObj.add(obj);
		}
		
		protected function fallBomb(yOffset:int, speed:int):void {
			var obj:Bomb = new Bomb(lane + StaticVars.bombOffSet, yOffset);
			obj.offset = new FlxPoint(0, -StaticVars.bombOffSet);
			obj.velocity.y = speed;
			_bombs.add(obj);
		}
		
		protected function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			but.play("green", false);
			this.score += 1;	
		}
		
		protected function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.killed) {
				b.kill();
				but.play("red", false);
				this.score -= bombScore;
			}
		}
	}
}