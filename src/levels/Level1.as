package levels 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.*;
	import main.*;
	import fall_object.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level1 extends FlxState {	
		[Embed(source = '../../img/wooden_bucket.png')] private static var bucketImg:Class;
		//////////////////////// scores ///////////////////////////
		public var score: Number;
		private var scoreText:FlxText;
		// count how many miss
		private var miss:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		/** Max score of a level, used for defining score bar*/
		private var maxScore:int;
		private var passScore:int;
		private var isMaxScore:Boolean;
		
		/////////////////////////// Time /////////////////////////////
		//private var max_time: Number;
		private var timer : FlxDelay;
		private var remainingTimeDisplay:FlxText;
		
		private var lane:int;
		
		//private var counter:int;
		//private var maxCount:int;
		
		
		
		
		//private var isDisplay:Boolean;
		
		// the current theme 
		//protected var currectTheme:int;
		// the current level that show on the screen
		
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		protected var _fallObj: FlxGroup;
		
		/////////////////////////// bomb /////////////////////////////
		//protected var _bombs: FlxGroup;
		//protected var bombScore:int;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket: BucketBar;
		

		
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		/////////////////////////// instr /////////////////////////////
		protected var instr:FlxText;
		protected var instrStr:String;
		public static const INSTRUCTION:String = "Catch everything!\nPress Enter to start.";
		
		/////////////////////////// pass perfect text /////////////////////////////
		protected var passText:FlxText;
		protected var perfectText:FlxText;
		
		
		private var lostText:FlxText;
		
				
		//protected var bonus:int;
		//protected var isStart:Boolean;
		
		//private var logData:Object;
		
		public function Level1():void {
			
			maxScore = StaticVars.a1MaxScore;
			passScore = maxScore * StaticVars.aPass;
			
			//missCount = 0;
			score = 0;

			timer = new FlxDelay(StaticVars.aTime);
			passText = null;
			perfectText = null;
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			
			instrStr = INSTRUCTION;
			
			//StaticVars.logger.logLevelStart(level + (StaticVars.C_THEME - 1) * 6, null);
			StaticVars.logger.logLevelStart(1, null);
			//trace("constructor");
			super();	
		}
	
		override public function create(): void {
			//StaticVars.logger.logLevelStart(1, null);
			_fallObj = new FlxGroup();
			add(_fallObj);	
			
			
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			//scoreBar = new FlxBar(15, 300, FlxBar.FILL_BOTTOM_TO_TOP, 50, 325, this, "score", 0, maxScore, true);
			scoreBar = new FlxBar(StaticVars.bucket_x - 3, StaticVars.bucket_y, FlxBar.FILL_BOTTOM_TO_TOP, 5, 40, this, "score", 0, maxScore, true);
			scoreBar.color = 0x141BE3;
			scoreBar.createFilledBar(0x88141BE3, 0xFF14e32c, false, 0x00000000);
			scoreBar.killOnEmpty = false;

			add(scoreBar);
			
			//var levelInstr2:FlxText;
			//levelInstr2 = new FlxText(0, 16, FlxG.width, "Level 1\nEsc to main menu");
			//levelInstr2.setFormat(null, 11, StaticVars.BLACK, "left");
			//add(levelInstr2);
			
			remainingTimeDisplay = new FlxText(0, 76, FlxG.width, "Time: "+ StaticVars.aTime/1000);
			remainingTimeDisplay.setFormat(null, 11, StaticVars.BLACK, "left");
			add(remainingTimeDisplay);
			
			scoreText = new FlxText(0, 96, FlxG.width, "Score: " + score + "\nMiss: " + miss);
			scoreText.setFormat(null, 11, StaticVars.BLACK, "left");
			add(scoreText);

			killBar = new FlxSprite(130, 640);
			killBar.makeGraphic(500, 5, StaticVars.INVISIBLE);
			add(killBar);
			
			instr = new FlxText(StaticVars.WIDTH/2 - FlxG.width/2, 250, FlxG.width, instrStr);
			instr.setFormat(null, 20, StaticVars.BLACK, "center");
			add(instr);
			
			bucket = new BucketBar(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y, scoreBar);
			add(bucket);
			
			lostText = new FlxText(100, 100, FlxG.width, "You Lost");
			lostText.setFormat(null, 20, StaticVars.BLACK, "center");
			
			super.create();
		}
		
		override public function update():void 
		{	
			//super.update();
			//trace(StaticVars.logger.getQ());
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
			
			if (miss >= StaticVars._1MaxMiss) {
				if (lostText.alpha >= 1) {
					add(lostText);
				}
				
				lostText.alpha -= 0.01;
				
				if (lostText.alpha <= 0) {
					endGame();
				}
				return pauseGroup.update();
			}
			
			isMaxScore = score >= maxScore;
			
			//scoreBar.x = bucket.x;
			
			if (Helper.genRandom(StaticVars.a1Interval) && !isMaxScore && !timer.hasExpired) 
			{
				lane = Helper.genLane(lane);
				_fallObj.add(Helper.fallObject(lane, StaticVars.yOffset, StaticVars.fallSpeedSlow, false));
			}
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			score = Helper.checkScore(score, maxScore);
			
			if (_fallObj.countLiving() <= 0 ) {
				endGame();
			}
			
			
			Helper.fadeText(perfectText);
			Helper.fadeText(passText);
			
			scoreText.text = "Score: " + score + "\nMiss: " + miss;
			remainingTimeDisplay.text = "Time: " + Math.max(0, timer.secondsRemaining);
			
			if (timer.secondsRemaining <= 5) {
				remainingTimeDisplay.color = StaticVars.RED;
			}
			/*
			// TODO
			if (isMaxScore) {
				//trace("Max");
				//scoreBar.color = StaticVars.YELLOW; // todo, won't work
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
			}*/
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:Bucket, obj:FallingObj):void {
			obj.kill();
			//obj.x = but.x;
			//trace(obj.y + " " + but.y);
			//if (obj.y >= but.y - 50) {
				but.play("green", false);
				this.score += 1;
				//obj.kill();
			//}
				
		}
		
		
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallingObj):void {
			obj.kill();
			miss++;

			
			//if (!isMaxScore && missCount++ > 5) {
			//	score--;
			//	missCount = 0;
			//}
		}

		
		private function endGame(): void {
			var logData:Object = {"finalScore":score, "misses":miss};
			StaticVars.logger.logLevelEnd(logData);
			var obj:Object = { "score":score, "miss":miss, "level":1, "passScore":passScore, "maxScore":maxScore };//"bonus":bonus, 
			Helper.dropCount = 0;
			Helper.endGame(obj);
		}
	}
}