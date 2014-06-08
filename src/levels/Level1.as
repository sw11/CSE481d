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
	public class Level1 extends FlxState {	
		//////////////////////// scores ///////////////////////////
		private var health:int;
		
		/** Displays the score, keeps tract of "score"*/
		private var scoreBar: FlxBar;
		
		private var spaceBarCount:int;
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
		private var ammoBox:AmmoBox;
		private var healthUp:Heart;
		private var firstBomb:Bomb;
		private var firstAmmo:Ammos;
		
		/////////////////////////// tank /////////////////////////////
		private var tank:Tank;
		
		/////////////////////////// track /////////////////////////////
		private var airplane:Airplane;
		private var airplaneFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		private var skipInstr:FlxText;
		private var lostText:FlxText;
		private var instrBool1:Boolean;
		private var instrBool2:Boolean;
		private var objArr:Array;
	
		private var level:int = 1;
		override public function create(): void {
			add(Helper.airBackground());
			StaticVars.logger.logLevelStart(level, null);
			_bombs = new FlxGroup();
			add(_bombs);	
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_bombLeft = StaticVars._6_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			
			instrBool1 = true;
			instrBool2 = true;
			///////////////// ammos//////////////////////////
			_ammos = new FlxGroup();
			add(_ammos);
			
			_ammoLeft = StaticVars._6_AMMO_COUNT + 1;
			
			ammoArr = new Array();
			add(new AmmoCount(10, 600));
			
			ammoText = new FlxText(30, 610, FlxG.width, "x" + _ammoLeft);
			ammoText.setFormat(null, 25, StaticVars.BLACK);
			add(ammoText);
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("We got you a tank!\nPress [Spacebar] to shoot the bomb\nStay alive & only shoot if you have to", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			skipInstr = Helper.addInstr("[S] to skip", 0, 450, StaticVars.RED, 15);
			add(skipInstr);
			/////////////////////// airplane ////////////////////////////
			airplane = new Airplane(StaticVars.PLANE_X, StaticVars.PLANE_Y);
			add(airplane);
			
			airplaneFillBar = new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, airplane, "numObjs", 0, _bombLeft, true);
			airplaneFillBar.trackParent(-13, 0);
			add(airplaneFillBar);
			
			firstBomb = new Bomb(StaticVars.TANK_X, 100);
			add(firstBomb);
			/////////////////////// bucket ////////////////////////////
			tank = new Tank(StaticVars.TANK_X, StaticVars.TANK_Y);
			add(tank);
			
			scoreBar = Helper.addTankHealthBar(Img.heart, 10);
			scoreBar.setParent(tank, "healthLeft", true, 10, 50);
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
			} else if (_bombLeft <= 0 && _bombs.countLiving() <= 0) {
				endGame();
			}
			
			if (++spaceBarCount > StaticVars._6_DROP_COUNT && FlxG.keys.justPressed("SPACE") && _ammoLeft > 0) {
				FlxG.play(SoundEffect.tankShoot);
				_ammos.add(Helper.fireAmmo(tank.x + 40));
				_ammoLeft--;
				ammoText.text = "x" + _ammoLeft;
				spaceBarCount = 0;
			} 
			if (_ammoLeft == 0) {
				// show no ammos
				ammoText.color = StaticVars.RED;
			} else if ( _ammoLeft > 0) {
				ammoText.color = StaticVars.BLACK;
			}
			
			tank.healthLeft = health;
			airplane.numObjs = _bombLeft;
			
			if (Helper.genRandom(StaticVars._6_FALL_RATE) && _bombLeft > 0)
			{
				if (health == 1 && healthUp == null && Helper.oneOf(10)) {
					// fall heart
					healthUp = new Heart(airplane.getX(), StaticVars.bombOffSet);
					add(healthUp);
				} else {
					var obj:Bomb = Helper.fallBomb(airplane.getX(), StaticVars.bombOffSet, StaticVars.fallSpeedSlow);
					_bombs.add(obj);
					objArr.push(obj);
					_bombLeft--;
				}
			}
			
				
			FlxG.overlap(killBar, _bombs, overlapKillBarObj);
			FlxG.overlap(tank, _bombs, overlapObjBucket);
			FlxG.overlap(_bombs, _ammos, overlapAmmoBomb);
			FlxG.overlap(tank, ammoBox, overlapTankAmmoBox);
			FlxG.overlap(tank, healthUp, overlapTankHealth);
			
			if (ammoBox != null && ammoBox.y > StaticVars.HEIGHT) {
				ammoBox.kill();
				ammoBox = null;
			}
			
			if (healthUp != null && healthUp.y > StaticVars.HEIGHT) {
				healthUp.kill();
				healthUp = null;
			}
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:Tank, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
				FlxG.play(SoundEffect.bomb);
				//hit by bomb is 4
				var ammoLeft:Object = { "ammo" : _ammoLeft };
				StaticVars.logger.logAction(4, ammoLeft);
			}
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
				FlxG.play(SoundEffect.bomb);
			}	
		}
		
		private function overlapTankHealth(tank:Tank, h:Heart):void {
			h.kill();
			healthUp = null;
			health ++;
			var healthObj:Object = {"health" : health };
			StaticVars.logger.logAction(9, healthObj);
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
				//trace("null: " + (ammoBox == null));
				if (ammoBox == null && _ammoLeft <= 10 && Helper.oneOf(10)) {
					ammoBox = new AmmoBox(bomb.x, bomb.y);
					add(ammoBox);
				}
				FlxG.play(SoundEffect.bomb);
				//kill bomb is 5
				var ammoLeft:Object = { "ammo" : _ammoLeft };
				StaticVars.logger.logAction(5, ammoLeft);
			}
		}

		private function overlapTankAmmoBox(tank:Tank, ab:AmmoBox):void {
			ab.kill();
			this.ammoBox = null;
			_ammoLeft += 5;
			ammoText.text = "x" + _ammoLeft;
			FlxG.play(SoundEffect.reload);
			//get ammo
			var ammoLeft:Object = { "ammo" : _ammoLeft};
			StaticVars.logger.logAction(6, ammoLeft)
		}
		//////////////////////////// tutorial ///////////////////////////
		private function tutorial():Boolean {
			
			
			/*if (FlxG.keys.ONE){
				bucket.tutorialBucketSwitching(ThreeBucket.TRASH);
			} */
			// skip tutorial
			if (FlxG.keys.justPressed("S")) {
				instruction.kill();
				skipInstr.kill();
				_ammoLeft = StaticVars._6_AMMO_COUNT;
				ammoText.text = "x" + _ammoLeft;
				firstBomb.kill();
				if (firstAmmo != null) {
					firstAmmo.kill();
				}
				paused = false;
			}
			
			if (!instrBool1 && firstAmmo != null) {
				FlxG.overlap(firstBomb, firstAmmo, firstAmmoBomb);
				firstAmmo.y -= 10;
			}
			
			if (instrBool1) {
				if (FlxG.keys.justPressed("SPACE")) {
					FlxG.play(SoundEffect.tankShoot);
					firstAmmo = new Ammos(StaticVars.TANK_X + 40, StaticVars.TANK_Y);
					add(firstAmmo);
					_ammoLeft--;
					ammoText.text = "x" + _ammoLeft;
					instruction.text = "The lower left indicates your bullets left\nPress [Enter] to start";
					instrBool1 = false;	
				}
				return true;
			}
			
			if (FlxG.keys.justPressed("ENTER")) {
				paused = !paused;
				instruction.kill();
				skipInstr.kill();
				if (!firstBomb.isKill()) {
					firstBomb.kill();
				}
				_ammoLeft = StaticVars._6_AMMO_COUNT;
				if (firstAmmo != null) {
					firstAmmo.kill();
				}
			}
			return true;
			/*
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
		
		private function  firstAmmoBomb(b:Bomb, a:Ammos):void {
			a.kill();
			if (!b.isKill()) {
				b.kill();
			}
		}
		
		private function endGame(): void {
			var obj:Object = {"health":health, "level":level }; 
			Helper.dropCount = 0;
			StaticVars.logger.logLevelEnd(obj);
			Helper.endgame(obj);
		}
	}
}