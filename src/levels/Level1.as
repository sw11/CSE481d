package levels 
{
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.Truck;
	import bucketBin.BucketBar;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level1 extends FlxState {	
		[Embed(source = '../../img/RecycleBin.png')] private static var bucketImg:Class;
		//////////////////////// scores ///////////////////////////
		//public var score: Number;
		//private var scoreText:FlxText;
		// count how many miss
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		/** Max score of a level, used for defining score bar*/
		//private var maxScore:int;
		//private var passScore:int;
		//private var isMaxScore:Boolean;
		
		/////////////////////////// Time /////////////////////////////
		//private var max_time: Number;
		//private var timer : FlxDelay;
		//private var remainingTimeDisplay:FlxText;
		
		//private var lane:int;
		
		//private var counter:int;
		//private var maxCount:int;
		
		/////////////////////////// toturial /////////////////////////////
		//private var startToturial:Boolean;
		//private var startFall:Boolean;
		//private var firstObj:FallObjs;
		private var instrBool2:Boolean;
		private var instrBool3:Boolean;
		private var instruction:FlxText;
		private var instrBool1:Boolean;
		private var skipInstr:FlxText;
		//private var isDisplay:Boolean;
		
		// the current theme 
		//protected var currectTheme:int;
		// the current level that show on the screen
		
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		protected var _fallObj: FlxGroup;
		private var _objLeft:int;
		/////////////////////////// bomb /////////////////////////////
		//protected var _bombs: FlxGroup;
		//protected var bombScore:int;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket: BucketBar;
		

		/////////////////////////// track /////////////////////////////
		private var truck:Truck;
		private var truckFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		/////////////////////////// instr /////////////////////////////
		//protected var instr:FlxText;
		//protected var instrStr:String;
		//public static const INSTRUCTION:String = "Catch everything!\nPress Enter to start.";
		
		
		
		/////////////////////////// pass perfect text /////////////////////////////
		//protected var passText:FlxText;
		//protected var perfectText:FlxText;
		
		
		private var lostText:FlxText;
		
				
		//protected var bonus:int;
		//protected var isStart:Boolean;
		
		//private var logData:Object;
		
		/*public function Level1():void {
			
			//maxScore = StaticVars.a1MaxScore;
			//passScore = maxScore * StaticVars.aPass;
			
			//missCount = 0;
			//score = 0;

			//timer = new FlxDelay(StaticVars.aTime);
			//passText = null;
			//perfectText = null;
			
			
			//StaticVars.logger.logLevelStart(level + (StaticVars.C_THEME - 1) * 6, null);
			//StaticVars.logger.logLevelStart(1, null);
			//trace("constructor");
			super();	
		}*/
	
		override public function create(): void {
			//StaticVars.logger.logLevelStart(1, null);
			_fallObj = new FlxGroup();
			add(_fallObj);	
			//startToturial = true;
			instrBool1 = true;
			instrBool2 = true;
			instrBool3 = true;
			//startFall = true;
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._1_TOTAL_OBJ;
			//instrStr = INSTRUCTION;
			health = StaticVars.TOTAL_HEALTH;
			
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			//scoreBar = new FlxBar(15, 300, FlxBar.FILL_BOTTOM_TO_TOP, 50, 325, this, "score", 0, maxScore, true);
			
			
			//var levelInstr2:FlxText;
			//levelInstr2 = new FlxText(0, 16, FlxG.width, "Level 1\nEsc to main menu");
			//levelInstr2.setFormat(null, 11, StaticVars.BLACK, "left");
			//add(levelInstr2);
			
			//remainingTimeDisplay = new FlxText(0, 76, FlxG.width, "Time: "+ StaticVars.aTime/1000);
			//remainingTimeDisplay.setFormat(null, 11, StaticVars.BLACK, "left");
			//add(remainingTimeDisplay);
			
			//scoreText = new FlxText(0, 96, FlxG.width, "Score: " + score + "\nMiss: " + miss);
			//scoreText.setFormat(null, 11, StaticVars.BLACK, "left");
			//add(scoreText);
			/////////////////////// killbar ////////////////////////////
			killBar = new FlxSprite(StaticVars.KILLBAR_X, StaticVars.KILLBAR_Y);
			killBar.makeGraphic(500, 5, StaticVars.RED);
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Left arrow to move bucket to left", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			skipInstr = Helper.addInstr("[S] to skip the tutoial", 0, 600, StaticVars.RED, 15);
			add(skipInstr);
			
			
			//instr = new FlxText(StaticVars.WIDTH/2 - FlxG.width/2, 250, FlxG.width, instrStr);
			//instr.setFormat(null, 20, StaticVars.BLACK, "center");
			//add(instr);
			/////////////////////// truck ////////////////////////////
			truck = new Truck(30, 5);
			add(truck);
			
			truckFillBar = new FlxBar(30, 5, FlxBar.FILL_BOTTOM_TO_TOP, 7, 45, truck, "numObjs", 0, _objLeft, true);
			//truckFillBar.color = 0x141BE3;
			//truckFillBar.createFilledBar(0x88141BE3, 0xFF14e32c, false, 0x00000000);
			truckFillBar.trackParent(93, 5);
			add(truckFillBar);
			/////////////////////// bucket ////////////////////////////
			bucket = new BucketBar(bucketImg, StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			scoreBar = new FlxBar(StaticVars.bucket_x, StaticVars.bucket_y, FlxBar.FILL_LEFT_TO_RIGHT, 90, 10, bucket, "healthLeft", 0, health, true);
			//scoreBar.color = 0x141BE3;
			//scoreBar.createFilledBar(0x88141BE3, 0xFF14e32c, false, 0x00000000);
			scoreBar.createImageBar(Objects.candy, null, 0x88000000, 0xFF000000);//, 0xff000000, 0xff00ff00);
			//scoreBar.killOnEmpty = false;
			scoreBar.trackParent(5, 50);
			//add(scoreBar);
			/////////////////////// lost instr ////////////////////////////
			lostText = new FlxText(0, 100, FlxG.width, "You Lost");
			lostText.setFormat(null, 20, StaticVars.BLACK, "center");
			
			super.create();
		}
		
		override public function update():void 
		{	
			//if (startToturial) {
			//	tutorial();
			//}
			if (paused && tutorial()) {
				//if (tutorial()) {
					return pauseGroup.update();
				//}
				//bucket.moveBucket();
			}
			/*
			if (instrBool1) {
				if (FlxG.keys.justPressed("LEFT")) {
					instrText1.text = "Right arrow to move bucket to right";
					instrBool1 = false;
				}
				return pauseGroup.update();
			
			} 
			
			if (instrBool2) {
				if (FlxG.keys.justPressed("RIGHT")) {
					instrText1.text = "Catch the falling object\nPress Enter to start";
					instrBool2 = false;
				}
				return pauseGroup.update();
			}
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instrText1.kill();
					add(scoreBar);
				//timer.start();
				}
				return pauseGroup.update();
			} */
			
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new LevelSelect());
			}
			
			//if (paused) {
			//	return pauseGroup.update();
			//}
			
			if (health <= 0) {
				if (lostText.alpha >= 1) {
					add(lostText);
				}
				
				lostText.alpha -= 0.01;
				
				if (lostText.alpha <= 0) {
					endGame();
				}
				return pauseGroup.update();
			} else if (_objLeft <= 0 && _fallObj.countLiving() <= 0) {
				endGame();
			}
			
			//isMaxScore = score >= maxScore;
			//bucket.score = score;
			//scoreBar.x = bucket.x;
			bucket.healthLeft = health;
			truck.numObjs = _objLeft;
			
			if (Helper.genRandom(StaticVars._1_FALL_RATE) && _objLeft > 0)// && !isMaxScore)// && !timer.hasExpired) 
			{
				var lane:int = truck.getX();// Helper.genLane(lane);
				_fallObj.add(Helper.fallObj(lane, StaticVars.yOffset, StaticVars.fallSpeedSlow, FallObjs.RECYCLE));
				_objLeft--;
			}
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			//score = Helper.checkScore(score, maxScore);
			
			//if (_fallObj.countLiving() <= 0 ) {
			//	endGame();
			//}
			
			
			//Helper.fadeText(perfectText);
			//Helper.fadeText(passText);
			
			//scoreText.text = "Score: " + score + "\nMiss: " + miss;
			//remainingTimeDisplay.text = "Time: " + Math.max(0, timer.secondsRemaining);
			
			//if (timer.secondsRemaining <= 5) {
			//	remainingTimeDisplay.color = StaticVars.RED;
			//}
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
		private function overlapObjBucket(but:BucketBar, obj:FallObjs):void {
			obj.kill();
			//obj.x = but.x;
			//trace(obj.y + " " + but.y);
			//if (obj.y >= but.y - 50) {
				but.play("green", false);
				//this.score += 1;
				//obj.kill();
			//}
				
		}
		
		private function tutorial():Boolean {
			//bucket.moveBucket();
			if (FlxG.keys.LEFT && bucket.x > 5){
				bucket.x -= 10;
			} 
			// skip tutorial
			if (FlxG.keys.justPressed("S")) {
				instruction.kill();
				skipInstr.kill();
				add(scoreBar);
				paused = false;
			}
			
			if (instrBool1) {
				if (FlxG.keys.justPressed("LEFT")) {
					instruction.text = "Right arrow to move bucket to right";
					instrBool1 = false;
				}
				return true;
			
			} 
			
			if (FlxG.keys.RIGHT && bucket.x < 405) {
				bucket.x += 10;
			} 
			
			if (instrBool2) {
				if (FlxG.keys.justPressed("RIGHT")) {
					instruction.text = "Object will fall from the truck\nPress Enter to continue";
					instrBool2 = false;
				}
				return true;
			}
			
			if (instrBool3) {
				if (FlxG.keys.justPressed("ENTER")) {
					instruction.text = "Catch all the falling object\nPress Enter to start";
					instrBool3 = false;
				}
				return true;
			}
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
					skipInstr.kill();
					add(scoreBar);
				//timer.start();
				}
				return true;
			} 
			
			return true;
			/*if (startFall) {
				firstObj = Helper.fallObj(truck.getX(), 0, StaticVars.fallSpeedSlow, FallObjs.RECYCLE);
				startFall = false;
			} //else if (firstObj != null && firstObj.y 
			
			//for (var i:int = 0;; i++) {
				//trace(i);
			//}*/
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallObjs):void {
			obj.kill();
			health--;
			FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_BOTH_AXES);
		}

		
		private function endGame(): void {
			//var logData:Object = {"finalScore":score, "misses":health};
			//StaticVars.logger.logLevelEnd(logData);
			var obj:Object = {"health":health, "level":1 };//"bonus":bonus, 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}