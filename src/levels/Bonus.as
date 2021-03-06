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
	public class Bonus extends FlxState {	
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
		//private var _bombLeft:int;
		private var _ammos:FlxGroup;
		private var ammoArr:Array;
		private var _ammoLeft:int;
		private var ammoText:FlxText;
		private var ammoBox:AmmoBox;
		private var healthUp:Heart;
		//private var firstBomb:Bomb;
		//private var firstAmmo:Ammos;
		
		/////////////////////////// tank /////////////////////////////
		private var tank:Tank;
		
		/////////////////////////// track /////////////////////////////
		private var airplane:Airplane;
		private var airplaneFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		//private var skipInstr:FlxText;
		private var lostText:FlxText;
		//private var instrBool1:Boolean;
		//private var instrBool2:Boolean;
		private var objArr:Array;
		private var level:int = 13;
	
		private var timerText:FlxText;
		//private var timer: FlxDelay;
		private var timer:Number;
		override public function create(): void {
			add(Helper.airBackground());
			StaticVars.logger.logLevelStart(level, null);
			_bombs = new FlxGroup();
			add(_bombs);	
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			//_bombLeft = StaticVars._8_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			timer = 0;
			//instrBool1 = true;
			//instrBool2 = true;
			///////////////// ammos//////////////////////////
			_ammos = new FlxGroup();
			add(_ammos);
			
			_ammoLeft = StaticVars._8_AMMO_COUNT;
			
			ammoArr = new Array();
			add(new AmmoCount(10, 600));
			ammoBox = null;
			ammoText = new FlxText(30, 610, FlxG.width, "x" + _ammoLeft);
			ammoText.setFormat("sourcesanspro", 25, StaticVars.BLACK);
			add(ammoText);
			
			timerText = new FlxText(StaticVars.WIDTH / 2, 610, FlxG.width, "0");
			timerText.setFormat("sourcesanspro", 25, StaticVars.BLACK);
			add(timerText);
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Survival mode!\nHow long can you stay alive?\nPress [Enter] to start", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			//skipInstr = Helper.addInstr("[S] to skip", 0, 450, StaticVars.RED, 15);
			//add(skipInstr);
			/////////////////////// airplane ////////////////////////////
			airplane = new Airplane(StaticVars.PLANE_X, StaticVars.PLANE_Y);
			add(airplane);
			
			//airplaneFillBar = new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, airplane, "numObjs", 0, _bombLeft, true);
			//airplaneFillBar.trackParent(-13, 0);
			//add(airplaneFillBar);
			
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
			
			if (paused) {
				if (FlxG.keys.justPressed("ENTER")) {
					paused = !paused;
					instruction.kill();
				} else {
					return pauseGroup.update();
				}	
			}
			timer += FlxG.elapsed;
			var t:int = Math.floor(timer);
			//trace(FlxG.elapsed, timer);
			timerText.text = "" + t;
			if (health <= 0) {
				/*if (lostText.alpha >= 1) {
					add(lostText);
				}
				lostText.alpha -= StaticVars.LOST_TEXT_ALPHA;
				if (lostText.alpha <= 0) {
					endGame();
				}
				return pauseGroup.update();*/
				endGame();
			} 
			/*else if (_bombLeft <= 0 && _bombs.countLiving() <= 0) {
				endGame();
			}*/
			
			if (++spaceBarCount > StaticVars._8_DROP_COUNT && FlxG.keys.justPressed("SPACE") && _ammoLeft > 0){
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
			//airplane.numObjs = _bombLeft;
			var fallRate:int;
			if (t < 60) {
				fallRate = StaticVars._BONUS_SLOW;
			} else if (t < 90) {
				fallRate = StaticVars._BONUS_MID;
			} else if (t < 120) {
				fallRate = StaticVars._BONUS_FAST;
			} else {
				fallRate = StaticVars._BONUS_SUPER_FAST;
			}
			if (Helper.genRandom(fallRate))
			{
				if (health == 1 && healthUp == null && Helper.oneOf(10)) {
					// fall heart
					healthUp = new Heart(airplane.getX(), StaticVars.bombOffSet);
					add(healthUp);
				} else if (ammoBox == null && _ammoLeft == 0 && Helper.oneOf(2)) {
					ammoBox = new AmmoBox(airplane.getX(), 10);
					add(ammoBox);
				} else {
					var obj:Bomb = Helper.fallBomb(airplane.getX(), StaticVars.bombOffSet, StaticVars.fallSpeedSlow);
					_bombs.add(obj);
					objArr.push(new Array(obj, 0, StaticVars._8_ALPHA));
					//_bombLeft--;
				}
			}
			
				
			FlxG.overlap(killBar, _bombs, overlapKillBarObj);
			FlxG.overlap(tank, _bombs, overlapObjBucket);
			FlxG.overlap(_bombs, _ammos, overlapAmmoBomb);
			FlxG.overlap(tank, ammoBox, overlapTankAmmoBox);
			FlxG.overlap(killBar, ammoBox, overlapAmmoBoxKillBar);
			FlxG.overlap(tank, healthUp, overlapTankHealth);
			FlxG.overlap(killBar, healthUp, overlapBarHealth);
			
			/*if (ammoBox != null && ammoBox.y > StaticVars.HEIGHT) {
				ammoBox.kill();
				ammoBox = null;
			}*/
			
			if (healthUp != null && healthUp.y > StaticVars.HEIGHT) {
				healthUp.kill();
				healthUp = null;
			}
			
			for (var i:int = objArr.length - 1; i >= 0 ; i--) {
				var fallObj:Bomb = objArr[i][0] as Bomb;
				if (fallObj == null || !fallObj.alive) {
					objArr.splice(i, 1);
					continue;
				}
				if (fallObj.y < 150 || fallObj.alpha > 1) {
					continue;
				}
				if ((++objArr[i][1]) % StaticVars._8_ALPHA_RATE == 0) {
					objArr[i][2] = -objArr[i][2];
				}
				fallObj.alpha -= objArr[i][2];
			}
			
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:Tank, bomb:Bomb):void {
			if (!bomb.isKill()) {
				FlxG.play(SoundEffect.bomb);
				bomb.kill();
				bomb.alpha = 0.99;
				but.play("minus");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
				//hit by bomb is 4
				var ammoLeft:Object = { "ammo" : _ammoLeft };
				StaticVars.logger.logAction(4, ammoLeft);
			}
		}
		
		private function overlapAmmoBoxKillBar(bar:FlxSprite, ab:AmmoBox):void {
			ab.kill();
			this.ammoBox = null;
		}
		
		private function overlapBarHealth(bar:FlxSprite, h:Heart):void {
			h.kill();
			this.healthUp = null;
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill()) {
				FlxG.play(SoundEffect.bomb);
				bomb.kill();
				bomb.alpha = 0.99;
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
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
			
			ammoObj.kill();
			if (!bomb.isKill()) {
				FlxG.play(SoundEffect.bomb);
				bomb.alpha = 0.99;
				bomb.kill();
				//trace("null: " + (ammoBox == null));
				if (ammoBox == null && (_ammoLeft <= 10 && Helper.oneOf(10))){
					ammoBox = new AmmoBox(bomb.x, bomb.y);
					add(ammoBox);
				}
				//kill bomb is 5
				var ammoLeft:Object = { "ammo" : _ammoLeft };
				StaticVars.logger.logAction(5, ammoLeft);
			}
		}

		private function overlapTankAmmoBox(tank:Tank, ab:AmmoBox):void {
			ab.kill();
			this.ammoBox = null;
			_ammoLeft += 10;
			ammoText.text = "x" + _ammoLeft;
			FlxG.play(SoundEffect.reload);
			//get ammo
			var ammoLeft:Object = { "ammo" : _ammoLeft};
			StaticVars.logger.logAction(6, ammoLeft)
		}
		
		private function endGame(): void {
			State.bonusTime = Math.max(Math.floor(timer), State.bonusTime);
			var obj:Object = {"health":health, "level":level }; 
			Helper.dropCount = 0;
			StaticVars.logger.logLevelEnd(obj);
			Helper.endgame(obj);
		}
	}
}