package levels 
{
	import bucketBin.Person;
	import bucketBin.Tank;
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.*;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level6 extends FlxState {	
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
		protected var _bombs:FlxGroup;
		private var _bombLeft:int;
		private var _ammos:FlxGroup;
		private var ammoArr:Array;
		private var _ammoLeft:int;
		private var ammoText:FlxText;
		private var ammoBox:FlxSprite;
		private var healthUp:FlxSprite;
		
		/////////////////////////// tank /////////////////////////////
		private var tank:Tank;
		
		/////////////////////////// track /////////////////////////////
		private var airplane:Airplane;
		private var airplaneFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
		
		private var objArr:Array;
	
		override public function create(): void {
			add(Helper.airBackground());
			//StaticVars.logger.logLevelStart(1, null);
			_bombs = new FlxGroup();
			add(_bombs);	
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_bombLeft = StaticVars._6_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			
			///////////////// ammos//////////////////////////
			_ammos = new FlxGroup();
			add(_ammos);
			
			
			
			_ammoLeft = StaticVars._6_AMMO_COUNT;
			
			ammoArr = new Array();
			add(new AmmoCount(10, 600));
			
			ammoText = new FlxText(30, 610, FlxG.width, "x" + _ammoLeft);
			ammoText.setFormat(null, 25, StaticVars.BLACK);
			add(ammoText);
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Protect yourself!\nAvoid bombs!\nPress enter to start", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			/////////////////////// airplane ////////////////////////////
			airplane = new Airplane(StaticVars.PLANE_X, StaticVars.PLANE_Y);
			add(airplane);
			
			airplaneFillBar = new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, airplane, "numObjs", 0, _bombLeft, true);
			airplaneFillBar.trackParent(-13, 0);
			add(airplaneFillBar);
			/////////////////////// bucket ////////////////////////////
			tank = new Tank(StaticVars.TANK_X, StaticVars.TANK_Y);
			add(tank);
			
			scoreBar = Helper.addTankHealthBar(Img.heart);
			scoreBar.setParent(tank, "healthLeft", true, 10, 50);
			add(scoreBar);
			/////////////////////// lost instr ////////////////////////////
			lostText = new FlxText(0, 100, FlxG.width, "You Lost");
			lostText.setFormat(null, 20, StaticVars.BLACK, "center");
			
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
					instruction.kill();
					paused = false;
				} else {
					return pauseGroup.update();
				}
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
			} else if (_bombLeft <= 0 && _bombs.countLiving() <= 0) {
				endGame();
			}
			
			if (FlxG.keys.justPressed("SPACE") && _ammoLeft > 0) {
				FlxG.play(SoundEffect.tankShoot);
				_ammos.add(Helper.fireAmmo(tank.x + 40));
				_ammoLeft--;
				ammoText.text = "x" + _ammoLeft;
			} else if (FlxG.keys.justPressed("SPACE") && _ammoLeft == 0) {
				// show no ammos
				ammoText.color = StaticVars.RED;
			}
			
			tank.healthLeft = health;
			airplane.numObjs = _bombLeft;
			
			if (Helper.genRandom(StaticVars._6_FALL_RATE) && _bombLeft > 0)
			{
				var obj:Bomb = Helper.fallBomb(airplane.getX(), StaticVars.bombOffSet, StaticVars.fallSpeedSlow);
				_bombs.add(obj);
				objArr.push(obj);
				_bombLeft--;
			}
			
				
			FlxG.overlap(killBar, _bombs, overlapKillBarObj);
			FlxG.overlap(tank, _bombs, overlapObjBucket);
			FlxG.overlap(_bombs, _ammos, overlapAmmoBomb);
			FlxG.overlap(tank, ammoBox, overlapTankAmmoBox);
			
			if (ammoBox != null && ammoBox.y > StaticVars.HEIGHT) {
				ammoBox.kill();
				ammoBox = null;
			}
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
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:Tank, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
			}
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
			}	
		}
		
		private function overlapAmmoBomb(bomb:Bomb, ammoObj:Ammos):void {
			
			/*if (!instrBool1) {
				instruction.kill();
				skipInstr.kill();
				//add(scoreBar);
				paused = false;
			}*/
			ammoObj.kill();
			if (!bomb.isKill()) {
				//bomb.alpha = 0.99;
				bomb.kill();
				trace("null: " + (ammoBox == null));
				if (ammoBox == null && _ammoLeft <= 10 && Helper.oneOf(10)) {
					ammoBox = new AmmoBox(bomb.x, bomb.y);
					add(ammoBox);
				}
			}
		}

		private function overlapTankAmmoBox(tank:Tank, ab:AmmoBox):void {
			ab.kill();
			this.ammoBox = null;
			_ammoLeft += 5;
			ammoText.text = "x" + _ammoLeft;
		}
		//////////////////////////// tutorial ///////////////////////////
		private function tutorial():Boolean {
			
			
			/*if (FlxG.keys.ONE){
				bucket.tutorialBucketSwitching(ThreeBucket.TRASH);
			} */
			// skip tutorial
			if (FlxG.keys.justPressed("ENTER")) {
				instruction.kill();
				paused = false;
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
			}*/
			
			/*if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
					skipInstr.kill();
					add(scoreBar);
				}
				return true;
			} */	
			return true;
		}
		
		
		private function endGame(): void {
			//var logData:Object = {"finalScore":score, "misses":health};
			//StaticVars.logger.logLevelEnd(logData);
			var obj:Object = {"health":health, "level":6 };//"bonus":bonus, 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}