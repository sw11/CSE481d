package levels 
{
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.Truck;
	import bucketBin.ThreeBucket;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level3 extends FlxState {	
		//////////////////////// scores ///////////////////////////
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		
		/////////////////////////// toturial /////////////////////////////
		private var instrBool2:Boolean;
		private var instrBool3:Boolean;
		private var instruction:FlxText;
		private var instrBool1:Boolean;
		private var skipInstr:FlxText;
		//private var instrBool4:Boolean;
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		protected var _fallObj: FlxGroup;
		private var _objLeft:int;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket:ThreeBucket;
		
		
		/////////////////////////// track /////////////////////////////
		private var truck:Truck;
		private var truckFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
	
		override public function create(): void {
			//StaticVars.logger.logLevelStart(1, null);
			_fallObj = new FlxGroup();
			add(_fallObj);	
			
			instrBool1 = true;
			instrBool2 = true;
			instrBool3 = true;
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._3_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			/////////////////////// killbar ////////////////////////////
			killBar = new FlxSprite(StaticVars.KILLBAR_X, StaticVars.KILLBAR_Y);
			killBar.makeGraphic(500, 5, StaticVars.RED);
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Black objects for trash bin\nPress 1 to switch to trash bin", 0, 250, StaticVars.BLACK, 20);
			add(instruction);

			skipInstr = Helper.addInstr("[S] to skip the tutoial", 0, 600, StaticVars.RED, 15);
			add(skipInstr);
			
			/////////////////////// truck ////////////////////////////
			truck = new Truck(30, 5);
			add(truck);
			
			truckFillBar = new FlxBar(30, 5, FlxBar.FILL_BOTTOM_TO_TOP, 7, 45, truck, "numObjs", 0, _objLeft, true);
			
			truckFillBar.trackParent(93, 5);
			add(truckFillBar);
			/////////////////////// bucket ////////////////////////////
			bucket = new ThreeBucket(StaticVars.bucket_x, StaticVars.bucket_y);
			add(bucket);
			
			scoreBar = new FlxBar(StaticVars.bucket_x, StaticVars.bucket_y, FlxBar.FILL_LEFT_TO_RIGHT, 90, 10, bucket, "healthLeft", 0, health, true);
			
			scoreBar.createImageBar(Objects.candy, null, 0x88000000, 0xFF000000);//, 0xff000000, 0xff00ff00);
			scoreBar.trackParent(5, 50);
			//add(scoreBar);
			/////////////////////// lost instr ////////////////////////////
			lostText = new FlxText(0, 100, FlxG.width, "You Lost");
			lostText.setFormat(null, 20, StaticVars.BLACK, "center");
			
			super.create();
		}
		
		/*private function addInstr(text:String, xPos:int, yPos:int, color:int):FlxText {
			var str:FlxText = new FlxText(xPos, yPos, FlxG.width, text);
			str.setFormat(null, 20, color, "center");
			return str;
		}*/
		
		
		override public function update():void 
		{	
			if (FlxG.keys.justPressed("ESCAPE")) {
				// need to log?
				FlxG.switchState(new LevelSelect());
			}
			
			if (paused && tutorial()) {
				return pauseGroup.update();
			}
				
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
			
			bucket.healthLeft = health;
			truck.numObjs = _objLeft;
			
			if (Helper.genRandom(StaticVars._3_FALL_RATE) && _objLeft > 0)
			{
				var lane:int = truck.getX();// Helper.genLane(lane);
				_fallObj.add(Helper.fallObj(lane, StaticVars.yOffset, StaticVars.fallSpeedSlow, FallObjs.ALL_THREE));
				_objLeft--;
			}
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:ThreeBucket, obj:FallObjs):void {
			if (but.getCurrentBucket() == obj.getCurrentObj()) {
				but.play("add");
			} else {
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_BOTH_AXES);
			}
			obj.kill();
		}
		
		private function tutorial():Boolean {
			
			
			if (FlxG.keys.ONE){
				bucket.tutorialBucketSwitching(ThreeBucket.TRASH);
			} 
			// skip tutorial
			if (FlxG.keys.justPressed("S")) {
				instruction.kill();
				skipInstr.kill();
				add(scoreBar);
				paused = false;
			}
			
			if (instrBool1) {
				if (FlxG.keys.justPressed("ONE")) {
					instruction.text = "Blue objects to recycle bin\nPress 2 to switch to recycle bin";
					instruction.color = StaticVars.BLUE;
					instrBool1 = false;
				}
				return true;
			
			} 
			
			if (FlxG.keys.TWO) {
				bucket.tutorialBucketSwitching(ThreeBucket.RECYCLE);
			} 
			
			if (instrBool2) {
				if (FlxG.keys.justPressed("TWO")) {
					instruction.text = "Green objects to compost bin\nPress 3 to switch to compost bin";
					instruction.color = StaticVars.GREEN;
					instrBool2 = false;
				}
				return true;
			}
			
			if (FlxG.keys.THREE) {
				bucket.tutorialBucketSwitching(ThreeBucket.COMPOST);
			} 
			
			if (instrBool3) {
				if (FlxG.keys.justPressed("THREE")) {
					instruction.text = "Catch all the falling object\nPress Enter to start";
					instruction.color = StaticVars.BLACK;
					instrBool3 = false;
				}
				return true;
			}
			
			/*if (instrBool4) {
				if (FlxG.keys.justPressed("ENTER")) {
					instruction.text = "Catch all the falling object\nPress Enter to start";
					instrBool4 = false;
				}
				return true;
			}*/
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
					skipInstr.kill();
					add(scoreBar);
				}
				return true;
			} 	
			return true;
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