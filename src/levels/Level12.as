package levels 
{
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.*;
	import bucketBin.*;
	
	/**
	 * Sea + shark
	 * @author Sam Wilson
	 */
	public class Level12 extends FlxState {	
		//////////////////////// scores ///////////////////////////
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		
		/////////////////////////// toturial /////////////////////////////
		//private var instrBool2:Boolean;
		//private var instrBool3:Boolean;
		private var instruction:FlxText;
		//private var instrBool1:Boolean;
		//private var skipInstr:FlxText;
		//private var firstAmmo:Ammos;
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		private var _poisonObj: FlxGroup;
		//private var _bombs:FlxGroup;
		private var _objLeft:int;
		private var spaceBarCount:int;
		private var _poison:FlxGroup;
		//private var _ammos:FlxGroup;
		//private var ammoArr:Array;
		//private var _ammoLeft:int;
		//private var ammoBox:FlxSprite;
		//private var healthUp:FlxSprite;
		
		/////////////////////////// bucket /////////////////////////////
		private var ship:Ship;
		
		/////////////////////////// fog /////////////////////////////
		protected var fog:FlxSprite;	
		protected var fogSpeedCount:int;
		
		/////////////////////////// Sharks /////////////////////////////
		private var _sharks:FlxGroup;
		
		/////////////////////////// fish /////////////////////////////
		private var fish:Fish;
		//private var hungryCounter:int;
		private var shipFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
		
		private var objArr:Array;
	
		override public function create(): void {
			StaticVars.logger.logLevelStart(12, null);
			//add sea background
			add(Helper.seaBackground());
			
			//StaticVars.logger.logLevelStart(1, null);
			_sharks = new FlxGroup();
			add(_sharks);	
			
			_poisonObj = new FlxGroup();
			add(_poisonObj);
			
			_poison = new FlxGroup();
			add(_poison);
			//_ammos = new FlxGroup();
			//add(_ammos);
			
			//_ammoLeft = 20;
			
			/*ammoArr = new Array();
			for (var i:int = _ammoLeft; i > 0; i--) {
				var a:AmmoCount = new AmmoCount(i * 23, 600);
				ammoArr.push(a);
				_ammos.add(a);
			}*/
			/*
			fog = new FlxSprite(StaticVars.fogXPos, StaticVars.fogYPos, fogImg);
			fog.alpha = 1;
			fog.velocity.y = StaticVars.fogSpeed;
			add(fog);
			*/
			//instrBool1 = true;
			//instrBool2 = true;
			//instrBool3 = true;
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._12_TOTAL_OBJ;

			health = StaticVars._11_HEALTH;
			
			spaceBarCount = StaticVars._10_DROP_COUNT;
			//set backgroud color
			FlxG.bgColor = StaticVars.BGCOLOR;
			
			//var s:Shark = new Shark(300, 300, 250, 350, 60);
			//_sharks.add(s);
			
			
			var s1:Shark = new Shark(300, 200, 150, 250, 60, 150);
			_sharks.add(s1);
			
			var s2:Shark = new Shark(400, 550, 400, 500, 40, 200);
			_sharks.add(s2);
			
			var s3:Shark = new Shark(10, 450, 400, 500, 150, 75);
			_sharks.add(s3);
			
			var s4:Shark = new Shark(100, 130, 80, 180, 100, 100);
			_sharks.add(s4);
			
			var s5:Shark = new Shark(370, 400, 370, 450, 40, 120);
			_sharks.add(s5);
			
			var s6:Shark = new Shark(StaticVars.SHIP_X, 180, 150, 200, 200, 20);
			_sharks.add(s6);
			
			var s7:Shark = new Shark(230, 600, 550, 640, 200, 400);
			_sharks.add(s7);
			/////////////////////// killbar ////////////////////////////
			//killBar = Helper.addKillBar();
			//add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Last level! Kill all sharks!!!\nPress [Enter] to start", 0, 220, StaticVars.BLACK, 20);
			add(instruction);

			//skipInstr = Helper.addInstr("[S] to skip the tutoial", 0, 450, StaticVars.RED, 15);
			//add(skipInstr);
			
			/////////////////////// Ship ////////////////////////////
			ship = new Ship(StaticVars.SHIP_X, StaticVars.SHIP_Y);
			add(ship);
			
			shipFillBar =  new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, ship, "numObjs", 0, _objLeft, true);
			shipFillBar.trackParent(-13, 0);
			add(shipFillBar);
			/////////////////////// bucket ////////////////////////////
			fish = new Fish(StaticVars.FISH_X, 300);
			fish.velocity.x = -350;
			add(fish);
			
			scoreBar = new FlxBar(StaticVars.FISH_X, 300 + 26,FlxBar.FILL_LEFT_TO_RIGHT, 158, 14);
			scoreBar.createImageBar(null, Img.heart, 0x0);
			scoreBar.setRange(0, 10);
			scoreBar.setParent(fish, "healthLeft", true, 0, 26);
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
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					// drop poison
					paused = false;
					instruction.kill();
				} else {
					return pauseGroup.update();
				}
			}
			
			/*if (++hungryCounter >= StaticVars._10_HUNGRY) {
				if (health == 1) {
					if (lostText.alpha >= 1) {
					add(lostText);
					}
					lostText.alpha -= StaticVars.LOST_TEXT_ALPHA;
					if (lostText.alpha <= 0) {
						health = 0;
						endGame();
					}
					return pauseGroup.update();
				}	
				health = Math.max(--health, 0);
				hungryCounter = 0;
			}*/

			if (++spaceBarCount > StaticVars._10_DROP_COUNT && FlxG.keys.justPressed("SPACE") && _objLeft > 0) {
				FlxG.play(SoundEffect.drop);
				var food:FallObjs = Helper.fallObj(ship.getX(), 50, StaticVars.fallSpeedFast, FallObjs.POISON);
				food.offset = new FlxPoint(0, -10);
				_poisonObj.add(food);
				_objLeft--;
				spaceBarCount = 0;
			} 
			
			if (health == 0 || _sharks.countLiving() ==  0 || (_objLeft <= 0 && _poisonObj.countLiving() <= 0)) {
				endGame();
			}
			
			fish.healthLeft = health;
			ship.numObjs = _objLeft;

			/*if (Helper.genRandom(StaticVars._6_FALL_RATE) && _objLeft > 0)
			{
				var lane:int = airplane.getX();// Helper.genLane(lane);
				var obj:Bomb = Helper.fallBomb(lane, StaticVars.yOffset, StaticVars.fallSpeedSlow);
				_bombs.add(obj);
				objArr.push(new Array(obj, 0, StaticVars.c5Alpha));
				_objLeft--;
			}*/
			
			//FlxG.overlap(killBar, _poisonObj, overlapKillBarObj);
			FlxG.overlap(fish, _poisonObj, overlapObjFish);
			FlxG.overlap(_sharks, _poisonObj, overlapObjShark);
			//trace(_fallObj.countLiving() + " " + _fallObj.length);
			//var arr:Array = _fallObj.members;
			/*for (var i:int = 0; i < objArr.length; i++) {
				var fo:FallObjs = objArr[i] as FallObjs;
				
				if (fo.y > 100 && fo.y < 200) {
					if (fo.x > 5) {
						fo.x -= 2;
					}
				}
			}*/
			/*
			if (++fogSpeedCount % StaticVars.fogRate == 0) {
				fog.velocity.y =  -fog.velocity.y;
				fogSpeedCount = 0;
			}
			
			for (var i:int = objArr.length - 1; i >= 0 ; i--) {
				var fallObj:Bomb = objArr[i][0] as Bomb;
				if (fallObj == null || !fallObj.alive) {
					objArr.splice(i, 1);
					continue;
				}
				if (fallObj.alpha > 1) {
					continue;
				}
				if ((++objArr[i][1]) % StaticVars.c5FogRate == 0) {
					objArr[i][2] = -objArr[i][2];
				}
				fallObj.alpha -= objArr[i][2];
			}*/
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapKillBarObj(killBar:FlxSprite, obj:FallObjs):void {
			obj.kill();
		}
		
		
		private function overlapObjFish(f:Fish, obj:FallObjs):void {
			health--;// = Math.min(StaticVars.TOTAL_HEALTH, ++health);
			obj.kill();
			//hungryCounter = 0;
			//feed fish aid code 8
			StaticVars.logger.logAction(8, null);
			fishSad();
			//fishHappy();
		}
		
		private function overlapObjShark(s:Shark, obj:FallObjs):void {
			obj.kill();
			s.kill();
			//feed shark aid code 7
			StaticVars.logger.logAction(7, null);
			fishHappy();
		}
		
		private function fishSad() : void {
			FlxG.play(SoundEffect.miss);
			add(new Sad(fish.x, fish.y-50, false));
		}
		
		private function fishHappy() : void {
			FlxG.play(SoundEffect.score);
			add(new Smile(fish.x, fish.y-50, false));
		}
		/*
		
		private function overlapAmmoBomb(bomb:Bomb, ammoObj:Ammos):void {
			
			if (!instrBool1) {
				instruction.kill();
				skipInstr.kill();
				//add(scoreBar);
				paused = false;
			}
			ammoObj.kill();
			if (!bomb.isKill()) {
				//bomb.alpha = 0.99;
				bomb.kill();
			}
			// may fall some good things
			//score++;
		}
*/
		//////////////////////////// tutorial ///////////////////////////
		/*private function tutorial():Boolean {
			/*
			FlxG.overlap(_bombs, _ammos, overlapAmmoBomb);
			if (!instrBool1 && _ammos.countLiving() > 0) {
				firstAmmo.y -= 3; 
			}
			if (FlxG.keys.ONE){
				bucket.tutorialBucketSwitching(ThreeBucket.TRASH);
			} 
			
			if (instrBool1 && FlxG.keys.justPressed("SPACE")) {
				(ammoArr.pop() as AmmoCount).kill(); 
				firstAmmo = Helper.fireAmmo(ship.x + 40)
				_ammos.add(firstAmmo);
				_ammoLeft--;
				instrBool1 = false;
			}
			// skip tutorial
			if (FlxG.keys.justPressed("S")) {
				instruction.kill();
				//skipInstr.kill();
				//add(scoreBar);
				paused = false;
			}
			
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.play(SoundEffect.drop);
				var food:FallObjs = Helper.fallObj(ship.getX(), 50, StaticVars.fallSpeedFast, FallObjs.FOOD);
				food.offset = new FlxPoint(0, -10);
				_poisonObj.add(food);
				paused = false;
				instruction.kill();
				skipInstr.kill();
			}
			/*
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
			
			if (instrBool4) {
				if (FlxG.keys.justPressed("ENTER")) {
					instruction.text = "Catch all the falling object\nPress Enter to start";
					instrBool4 = false;
				}
				return true;
			}
			
			/*if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
					skipInstr.kill();
					add(scoreBar);
				}
				return true;
			} 	
			return true;
		}*/
		
		
		private function endGame(): void {
			if (_sharks.countLiving() > 0) {
				health = 0;
			}
			var obj:Object = {"health":health, "level":12 }; 
			Helper.dropCount = 0;
			StaticVars.logger.logLevelEnd(obj);
			Helper.endgame(obj);
		}
	}
}