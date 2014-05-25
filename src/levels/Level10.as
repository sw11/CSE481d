package levels 
{
	import bucketBin.Person;
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
	public class Level10 extends FlxState {	
		[Embed(source = '../../img/fog_3.png')] protected static var shark:Class;
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
		private var firstAmmo:Ammos;
		
		/////////////////////////// Killbar /////////////////////////////
		protected var killBar:FlxSprite;
		
		//protected var missCount:int;
		/////////////////////////// Fall obj /////////////////////////////
		private var _fallObj: FlxGroup;
		//private var _bombs:FlxGroup;
		private var _objLeft:int;
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
		//private var airplane:Airplane;
		private var shipFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
		
		private var objArr:Array;
	
		override public function create(): void {
			//StaticVars.logger.logLevelStart(1, null);
			_sharks = new FlxGroup();
			add(_sharks);	
			
			_fallObj = new FlxGroup();
			add(_fallObj);
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
			instrBool1 = true;
			instrBool2 = true;
			instrBool3 = true;
			
			objArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_objLeft = StaticVars._6_TOTAL_OBJ;

			health = StaticVars.TOTAL_HEALTH;
			
			//set backgroud color
			FlxG.bgColor = 0xeeeeeeee;
			
			var s:Shark = new Shark(300, 300);
			_sharks.add(s);
			
			/////////////////////// killbar ////////////////////////////
			killBar = new FlxSprite(StaticVars.KILLBAR_X, StaticVars.KILLBAR_Y);
			killBar.makeGraphic(500, 5, StaticVars.RED);
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Bomb is falling!\nPress spacebar to shoot the bomb!", 0, 250, StaticVars.BLACK, 20);
			add(instruction);

			skipInstr = Helper.addInstr("[S] to skip the tutoial", 0, 450, StaticVars.RED, 15);
			add(skipInstr);
			
			/////////////////////// truck ////////////////////////////
			//airplane = new Airplane(30, 5);
			//add(airplane);
			ship = new Ship(30, 5);
			add(ship);
			
			shipFillBar = new FlxBar(30, 5, FlxBar.FILL_BOTTOM_TO_TOP, 7, 45, ship, "numObjs", 0, _objLeft, true);
			
			shipFillBar.trackParent(93, 5);
			add(shipFillBar);
			/////////////////////// bucket ////////////////////////////
			fish = new Fish(StaticVars.BUCKET_X, StaticVars.BUCKET_Y);
			add(fish);
			
			scoreBar = new FlxBar(StaticVars.BUCKET_X, StaticVars.BUCKET_Y, FlxBar.FILL_LEFT_TO_RIGHT, 90, 10, fish, "healthLeft", 0, health, true);
			
			scoreBar.createImageBar(Objects.candy, null, 0x88000000, 0xFF000000);//, 0xff000000, 0xff00ff00);
			scoreBar.trackParent(5, 50);
			//add(scoreBar);
			/////////////////////// lost instr ////////////////////////////
			lostText = new FlxText(0, 100, FlxG.width, "You Lost");
			lostText.setFormat(null, 20, StaticVars.BLACK, "center");
			
			/////////////////////// add bomb for tutorial ////////////////////////////
			//_bombs.add(Helper.fallBomb(ship.x, 300, StaticVars.fallSpeedMid));
			
			super.create();
		}
		
		
		override public function update():void 
		{			
			if (FlxG.keys.justPressed("ESCAPE")) {
				// need to log?
				FlxG.switchState(new LevelSelect());
			}
			
			if (paused && tutorial()) {
				return pauseGroup.update();
			}

			if (FlxG.keys.justPressed("SPACE") && _objLeft > 0) {
				var food:FallObjs = Helper.fallObj(ship.getX(), 50, StaticVars.fallSpeedMid, FallObjs.FOOD);
				_fallObj.add(food);
				_objLeft--;
			} else if (FlxG.keys.justPressed("SPACE") && _objLeft == 0) {
				// show no ammos
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
			
			FlxG.overlap(killBar, _fallObj, overlapKillBarObj);
			//FlxG.overlap(ship, _bombs, overlapObjBucket);
			//FlxG.overlap(_bombs, _ammos, overlapAmmoBomb);
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
			obj.velocity.y = 0;
			/*
			if (!bomb.isKill()) {
				bomb.kill();
				//but.play("minus");
				//this.score -= bombScore;
				//FlxG.shake(0.04, 0.1, null, true, 1);
			}	*/
		}
		/*
		private function overlapObjBucket(but:Tank, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
				but.play("minus");
				//this.score -= bombScore;
				health--;
				FlxG.shake(0.04, 0.1, null, true, 1);
			}
		}
		
		
		
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
		private function tutorial():Boolean {
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
			}*/
			// skip tutorial
			if (FlxG.keys.justPressed("S")) {
				instruction.kill();
				skipInstr.kill();
				//add(scoreBar);
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
			var obj:Object = {"health":health, "level":1 };//"bonus":bonus, 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}