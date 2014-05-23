package levels 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.*;
	import fall_object.*;
	import main.*;
	
	/**
	 * Default class for each level, holding common aspects such as timer and score
	 * 
	 * @author Sam Wilson
	 */
	public class PlayState extends FlxState {
		
		[Embed(source = '../../img/fog_3.png')] protected static var fogImg:Class;
		
		///////////////////////////// score //////////////////////////////
		/** Keep track of current score*/
		protected var score: Number;
		// object to miss
		public var miss:int;
		// count how many miss in order to lose one point
		protected var missCount:int;
		/** Displays the score, keeps tract of "score"*/
		public var scoreBar: FlxBar;
		/** Max score of a level, used for defining score bar*/
		protected var maxScore:int;
		// pass score
		protected var passScore:int;
		
		
		private var counter:int;
		// max count interval for the falling objects
		private var maxCount:int;
		
		
		// the current level that show on the screen
		protected var level:int;
		protected var lane:int;
		
		protected var isMaxScore:Boolean;
		protected var bonus:int;
		protected var isStart:Boolean;
		
		///////////////////////////// time //////////////////////////////
		protected var remainingTimeDisplay:FlxText;
		private var max_time: Number;
		protected var timer : FlxDelay;
		

		///////////////////////////// kill bars //////////////////////////////
		protected var killBar:FlxSprite;
		protected var topKillBar:FlxSprite;
		
		///////////////////////////// objs //////////////////////////////
		protected var _fallObj: FlxGroup;
		protected var _objArr:Array;
		
		///////////////////////////// bomb //////////////////////////////
		protected var _bombs:FlxGroup;
		protected var _bombArr:Array;
		protected var bombScore:int;
		
		///////////////////////////// ammo //////////////////////////////
		protected var _ammos:FlxGroup;
		protected var ammo:int;
		protected var ammoText:FlxText;
		
		///////////////////////////// fog //////////////////////////////
		protected var fog:FlxSprite;	
		protected var fogSpeedCount:int;
		
		///////////////////////////// instructions //////////////////////////////
		protected var instr:FlxText;
		protected var instrStr:String;
		private var scoreText:FlxText;
		
		
		
		
		
		///////////////////////////// paused  //////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		protected var passText:FlxText;
		protected var perfectText:FlxText;
		
		
		protected var theme:int;
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
			instr.setFormat(null, 20, StaticVars.BLACK, "center");
			add(instr);
		}
	
		override public function update():void {
			
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
				
			fadeText();
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(killBar, _bombs, overlapKillBarBomb);
			
			super.update();
			
			
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
				passText = null;
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
		

		//////////////////////////////// Add objects /////////////////////////////////////////
		
		// Add fall objects
		protected function fallObject(yOffset:int, speed:int):FallingObj {
			var obj:FallingObj = new FallingObj(lane, yOffset, theme == State.RECYCLE);
			obj.velocity.y = speed;
			_fallObj.add(obj);
			if (theme == State.FOG) {
				obj.alpha = 0.99;
			}
			return obj;
		}
		
		// Add bomb
		protected function fallBomb(yOffset:int, speed:int):Bomb {
			var obj:Bomb = new Bomb(lane + StaticVars.bombOffSet, yOffset);
			obj.offset = new FlxPoint(0, -StaticVars.bombOffSet);
			obj.velocity.y = speed;
			if (theme == State.FOG) {
				obj.alpha = 0.99;
			}
			_bombs.add(obj);
			return obj;
		}
		
		// add ammo
		protected function fireAmmo(xPos:int):void {
			ammo -= 1;
			_ammos.add(new Ammos(xPos, 550));
		}
		
		
		//////////////////////////////// overlaps /////////////////////////////////////////
		
		// bucket v.s. objects
		protected function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			if (theme == State.RECYCLE) {
				if (but.getCurrentBucket() == b.getCurrentObj()) {
					this.score += 1;	
					bucket.play("add");
				} else {
				//this.score -= 1;
					miss++;
					bucket.play("minus");
				}
			} else {
				but.play("green", false);
				this.score += 1;
			}
		}
		
		// bucket v.s. bomb
		protected function overlapBombBucket(but:Bucket, b:Bomb):void {
			if (!b.killed) {
				b.kill();
				but.play("red", false);
				this.score -= bombScore;
				FlxG.shake(0.04, 0.1, null, true, 1);
			}
		}
		
		// killbar v.s. objects
		protected function overlapKillBarObj(killBar:FlxSprite, obj:FallingObj):void {
			obj.kill();
			miss++;
			// lost points?
			if (!isMaxScore && missCount++ > 5) {
				score--;
				missCount = 0;
			}
		}
		
		// killbar v.s. bomb
		protected function overlapKillBarBomb(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill())
				bomb.kill();
		}
		
		// top bar v.s. ammo
		protected function  overlapTopKillBarAmmo(ammoObj:Ammos, topBar:FlxSprite):void {
			ammoObj.kill();
		}

		// ammo v.s. bomb
		protected function overlapAmmoBomb(ammoObj:Ammos, bomb:Bomb):void {
			ammoObj.kill();
			if (!bomb.isKill()) {
				bomb.alpha = 0.99;
				bomb.kill();
			}
			score++;
		}
	}
}