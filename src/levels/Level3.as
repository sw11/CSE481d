package levels 
{
	import bucketBin.ThreeBucket;
	import bucketBin.TwoBucket;
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.Truck;
	
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
		private var instruction:FlxText;
		private var instrBool1:Boolean;
		private var instrBool3:Boolean;
		private var skipInstr:FlxText;
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		protected var _fallObj: FlxGroup;
		private var _objLeft:int;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket: ThreeBucket;
		
		/////////////////////////// track /////////////////////////////
		private var truck:Truck;
		private var truckFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
	
		override public function create(): void {
			add(Helper.landBackground());
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
			
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Black objects for trash bin\nPress [1] to switch to trash bin", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			skipInstr = Helper.addInstr("[S] to skip", 0, 450, StaticVars.RED, 15);
			add(skipInstr);
			
			/////////////////////// truck ////////////////////////////
			truck = new Truck(StaticVars.TRUCK_X, StaticVars.TRUCK_Y);
			add(truck);
			
			truckFillBar = new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, truck, "numObjs", 0, _objLeft, true);
			truckFillBar.trackParent(-13, 0);
			add(truckFillBar);
			/////////////////////// bucket ////////////////////////////
			bucket = new ThreeBucket(StaticVars.BUCKET_X, StaticVars.BUCKET_Y);
			add(bucket);
			
			scoreBar = Helper.addHealthBar(Img.heart);
			scoreBar.setParent(bucket, "healthLeft", true, 10, 50);
			add(scoreBar);
			/////////////////////// lost instr ////////////////////////////
			lostText = Helper.addLostText();
			super.create();
		}
		
		override public function update():void 
		{	
			scoreBar.currentValue = health;
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
				lostText.alpha -= StaticVars.LOST_TEXT_ALPHA;
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
				_fallObj.add(Helper.fallObj(truck.getX(), StaticVars.yOffset, StaticVars.fallSpeedSlow, FallObjs.ALL_THREE));
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
				add(new Star(obj.x, obj.y+50, true));
				add(new Star(obj.x+50, obj.y+50, false));
			} else {
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
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
				paused = false;
			}
			
			if (instrBool1) {
				if (FlxG.keys.justPressed("ONE")) {
					instruction.text = "Blue objects to recycle bin\nPress [2] to switch to recycle bin";
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
					instruction.text = "Green objects to compost bin\nPress [3] to switch to compost bin";
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
					instruction.text = "Catch all the falling object\nPress [Enter] to start";
					instruction.color = StaticVars.BLACK;
					instrBool3 = false;
				}
				return true;
			}
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
					skipInstr.kill();
				}
				return true;
			} 
			
			return true;
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallObjs):void {
			obj.kill();
			health--;
			bucket.play("minus");
			FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
		}

		
		private function endGame(): void {
			//var logData:Object = {"finalScore":score, "misses":health};
			//StaticVars.logger.logLevelEnd(logData);
			var obj:Object = {"health":health, "level":3 }; 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}