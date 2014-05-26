package levels 
{
	import bucketBin.Person;
	import bucketBin.ThreeBucket;
	import bucketBin.TwoBucket;
	import cgs.teacherportal.activity.ProblemSetLogger;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxBar;
	import transportation.Airplane;
	import utility.*;
	import main.*;
	import fall_object.*;
	import transportation.Truck;
	
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class Level5 extends FlxState {	
		
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
		protected var _bombs: FlxGroup;
		private var _bombLeft:int;
		private var bombArr:Array;
		
		/////////////////////////// bucket /////////////////////////////
		private var person: Person;
		
		/////////////////////////// track /////////////////////////////
		private var airplane:Airplane;
		private var airplaneFillBar:FlxBar;
		
		/////////////////////////// tutorial /////////////////////////////
		protected var paused:Boolean;
		protected var pauseGroup:FlxGroup;
		
		private var lostText:FlxText;
		
		///private var cloud:FlxSprite;
	
		override public function create(): void {
			add(Helper.airBackground());
			//StaticVars.logger.logLevelStart(1, null);
			_bombs = new FlxGroup();
			add(_bombs);	
			
			bombArr = new Array();
			
			paused = true;
			pauseGroup = new FlxGroup();
			
			_bombLeft = StaticVars._5_TOTAL_OBJ;

			health = StaticVars._5_TOTAL_HEALTH;
			
			
			//cloud = new FlxSprite(0, 80);
			//cloud.loadGraphic(Img.cloud, true, false, 500, 264);
			//add(cloud);
			/////////////////////// killbar ////////////////////////////
			killBar = Helper.addKillBar();
			add(killBar);
			/////////////////////// tutorial ////////////////////////////
			
			instruction = Helper.addInstr("Protect yourself!\nAvoid bombs!\nPress [Enter] to start", 0, 250, StaticVars.BLACK, 20);
			add(instruction);
			
			/////////////////////// truck ////////////////////////////
			airplane = new Airplane(StaticVars.TRUCK_X, StaticVars.TRUCK_Y);
			add(airplane);
			
			airplaneFillBar = new FlxBar(15, 5, FlxBar.FILL_BOTTOM_TO_TOP, 10, 60, airplane, "numObjs", 0, _bombLeft, true);
			airplaneFillBar.trackParent(-13, 0);
			add(airplaneFillBar);
			/////////////////////// bucket ////////////////////////////
			person = new Person(StaticVars.TANK_X, StaticVars.TANK_Y);
			add(person);
			
			scoreBar = Helper.addTankHealthBar(Img.heart, 0);
			scoreBar.setParent(person, "healthLeft", true, 0, 50);
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
			
			person.healthLeft = health;
			airplane.numObjs = _bombLeft;
			
			if (Helper.genRandom(StaticVars._5_FALL_RATE) && _bombLeft > 0)
			{
				var obj:Bomb = Helper.fallBomb(airplane.getX(), StaticVars.bombOffSet, StaticVars.fallSpeedSlow);
				_bombs.add(obj);
				bombArr.push(obj);
				_bombLeft--;
			}
			
			FlxG.overlap(killBar, _bombs, overlapKillBarObj);
			FlxG.overlap(person, _bombs, overlapObjBucket);
			
			super.update();
		}
		
		
		//////////////////////////// overlap ///////////////////////////
		private function overlapObjBucket(but:Person, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
				but.play("red");
				health--;
				FlxG.shake(0.05, 0.1, null, true, FlxCamera.SHAKE_HORIZONTAL_ONLY);
			}	
		}
		
		private function tutorial():Boolean {
			if (FlxG.keys.justPressed("ENTER")) {
				paused = !paused;
				instruction.kill();
			}
			return true;
		}
		
		private function overlapKillBarObj(killBar:FlxSprite, bomb:Bomb):void {
			if (!bomb.isKill()) {
				bomb.kill();
			}
		}

		
		private function endGame(): void {
			//StaticVars.logger.logLevelEnd(logData);
			var obj:Object = {"health":health, "level":5}; 
			Helper.dropCount = 0;
			Helper.endgame(obj);
		}
	}
}