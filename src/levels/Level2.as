package levels 
{
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
	public class Level2 extends FlxState {	
		
		//////////////////////// scores ///////////////////////////
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		
		/////////////////////////// toturial /////////////////////////////
		private var instrBool2:Boolean;
		private var instruction:FlxText;
		private var instrBool1:Boolean;
		private var skipInstr:FlxText;
		
		/////////////////////////// Killbar /////////////////////////////
		private var killBar:FlxSprite;
		
		/////////////////////////// Fall obj /////////////////////////////
		private var _fallObj: FlxGroup;
		private var _objLeft:int;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket: TwoBucket;
		
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
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._2_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH
			
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
			bucket = new TwoBucket(StaticVars.BUCKET_X, StaticVars.BUCKET_Y);
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
			
			if (Helper.genRandom(StaticVars._2_FALL_RATE) && _objLeft > 0)
			{
				_fallObj.add(Helper.fallObj(truck.getX(), StaticVars.yOffset, StaticVars.fallSpeedSlow, FallObjs.TRASH_RECYCLE));
				_objLeft--;
			}
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			super.update();
		}
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:TwoBucket, obj:FallObjs):void {
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
		
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallObjs):void {
			obj.kill();
			health--;
			bucket.play("minus");
			FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
		}
		
		//////////////////////////// tutorial ///////////////////////////
		private function tutorial():Boolean {
			if (FlxG.keys.ONE){
				bucket.tutorialBucketSwitching(TwoBucket.TRASH);
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
				bucket.tutorialBucketSwitching(TwoBucket.RECYCLE);
			} 
			
			if (instrBool2) {
				if (FlxG.keys.justPressed("TWO")) {
					instruction.text = "Catch all the falling object\nPress [Enter] to start";
					instruction.color = StaticVars.BLACK;
					instrBool2 = false;
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
		
		

		
		private function endGame(): void {
			//var logData:Object = {"finalScore":score, "misses":health};
			//StaticVars.logger.logLevelEnd(logData);
			var obj:Object = {"health":health, "level":2 };//"bonus":bonus, 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}