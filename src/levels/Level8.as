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
	public class Level8 extends FlxState {	
		
		//////////////////////// scores ///////////////////////////
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		
		/////////////////////////// toturial /////////////////////////////
		private var instruction:FlxText;
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		protected var _fallObj: FlxGroup;
		private var _objLeft:int;
		private var objArr:Array;
		
		/////////////////////////// bucket /////////////////////////////
		private var bucket: ThreeBucket;
		
		/////////////////////////// track /////////////////////////////
		private var truck:Truck;
		private var truckFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
		private var level:int = 8;
	
		override public function create(): void {
			FlxG.play(SoundEffect.wind,1,true);
			add(Helper.landBackground());
			StaticVars.logger.logLevelStart(level, null);
			_fallObj = new FlxGroup();
			add(_fallObj);	
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._4_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Looks like its going to be windy\nPress [Enter] to start", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
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
			
			if (Helper.genRandom(StaticVars._4_FALL_RATE) && _objLeft > 0)
			{
				var obj:FallObjs = Helper.fallObj(truck.getX(), StaticVars.yOffset, StaticVars.fallSpeedSlow, FallObjs.ALL_THREE);
				_fallObj.add(obj);
				objArr.push(new Array(obj, Math.random() < 0.5 ? 2 : -2));
				_objLeft--;
			}
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			FlxG.overlap(bucket, _fallObj, overlapObjBucket);
			
			for (var i:int = 0; i < objArr.length; i++) {
				var fo:FallObjs = objArr[i][0] as FallObjs;
				if (fo.y > 100 && fo.y < 300) {
					fo.x += objArr[i][1];
					if (fo.x <= 5 || fo.x >= 430) {
						objArr[i][1] = -objArr[i][1];
					} 
				}
			}
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:ThreeBucket, obj:FallObjs):void {
			var logData:Object = { "bucket" : but.getCurrentBucket(), "object" : obj.getCurrentObj() };
			if (but.getCurrentBucket() == obj.getCurrentObj()) {
				FlxG.play(SoundEffect.score);
				but.play("add");
				add(new Star(obj.x, obj.y+50, true));
				add(new Star(obj.x + 50, obj.y + 50, false));
				StaticVars.logger.logAction(1, logData);
			} else {
				FlxG.play(SoundEffect.miss);
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
				StaticVars.logger.logAction(2, logData);
			}
			obj.kill();			
		}
		
		private function tutorial():Boolean {
			if (FlxG.keys.justPressed("ENTER")) {
				paused = !paused;
				instruction.kill();
			}
			return true;
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallObjs):void {
			FlxG.play(SoundEffect.miss);
			obj.kill();
			health--;
			bucket.play("minus");
			FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
			StaticVars.logger.logAction(3, null);
		}

		
		private function endGame(): void {
			var obj:Object = {"health":health, "level":level}; 
			Helper.dropCount = 0;
			StaticVars.logger.logLevelEnd(obj);
			Helper.endgame(obj);
		}
	}
}