package levels 
{
	import fall_object.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	import utility.*;
	import main.*;
	/**
	 * ...
	 * @author Sam
	 */
	public class Helper 
	{
		
		public static var dropCount:int;
		private static var counter:int;
		
		public static  function fadeText(perfectText:FlxText): void {
			if (perfectText != null) {
				if (perfectText.alpha <= 0 ) {
					perfectText.kill();
				} else {
					perfectText.alpha = perfectText.alpha - 0.005;
				}
			}
		}
		
		public static function checkScore(score:int, maxScore:int):int {
			return Math.max(0, Math.min(score, maxScore));
		}
		
		public static function genRandom(interval:int):Boolean {
			// it will always be true for the very first time
			if (counter++ >= dropCount) {
				counter = 0;
				dropCount = Math.random() * 40 + interval;
				return true;
			} 
			return false;
		}
		
		/*protected function resetCount(interval:int):void {
			counter = 0;
			maxCount = Math.random() * 20 + interval;
		}*/
		
		public static function genLane(preLane:int):int {
			var lane:int;
			// from 155 to 530
			lane = Math.random() * 375 + 155;
			//while ((lane = FlxU.getRandom(StaticVars.lanes, 0, StaticVars.lanes.length) as int) == preLane){}
			return lane;
		}
		
		public static function oneOf(num:int):Boolean {
			return randNum(num) == 1;
		}
		
		public static function randNum(num:int):int {
			return Math.floor(Math.random() * num);
		}
		
		public static function endgame(data:Object): void {
			
			var level:int = data["level"];
			
			var health:int = data["health"];
			
			if (health > 0) {
				// win
				//if (level == State.unlockLevel) {
				State.toNextLevel(level);
				//}
				if (health == 5 || (level == 1 && health == 3) || level >= 11) {
					State.star(level);
				}
				FlxG.switchState(new FinishState("WIN", health, level));
			} else if (level == 13) {
				FlxG.switchState(new FinishState("Your best time: " + State.bonusTime + "s", health, level));
			} else {
				// lost
				FlxG.switchState(new FinishState("LOST", health, level));
			}
		}
		
		///////////////////////////// Fall objects /////////////////////////////////
		
		// new one
		public static function fallObj(lane:int, yOffset:int, speed:int, whichObj:int):FallObjs {
			var obj:FallObjs = new FallObjs(lane, 0, whichObj);
			obj.velocity.y = speed;
			return obj
		}
		
		///////////////////////////// Fall bombs /////////////////////////////////
		// new one
		public static function fallBomb(lane:int, yOffset:int, speed:int):Bomb {
			var obj:Bomb = new Bomb(lane, yOffset);
			obj.velocity.y = speed;
			return obj
		}
		
		public static function fireAmmo(xPos:int):Ammos {
			//ammo -= 1;
			var ammo:Ammos = new Ammos(xPos, 500);
			return ammo;
			//_ammos.add(new Ammos(xPos, 550));
		}
		
		public static function addLostText():FlxText {
			var lostText:FlxText = new FlxText(0, 300, FlxG.width, "You Lost");
			lostText.setFormat(null, 30, StaticVars.RED, "center");
			return lostText;
		}
		
		public static function addHungryText():FlxText {
			var lostText:FlxText = new FlxText(0, 300, FlxG.width, "You Lost!\nThe fish is too hungry!");
			lostText.setFormat(null, 30, StaticVars.RED, "center");
			return lostText;
		}
		
		public static function addInstr(text:String, xPos:int, yPos:int, color:int, fontSize:int):FlxText {
			var str:FlxText = new FlxText(xPos, yPos, FlxG.width, text);
			str.setFormat("sourcesanspro", fontSize, color, "center");
			return str;
		}
		
		public static function addHealthBar(graphic:Class):FlxBar {
			var scoreBar:FlxBar = new FlxBar(StaticVars.BUCKET_X + 10, StaticVars.BUCKET_Y + 50,FlxBar.FILL_LEFT_TO_RIGHT, 158, 14);
			scoreBar.createImageBar(null, graphic, 0x0);
			scoreBar.setRange(0, 10);
			return scoreBar;
		}
		
		public static function addTankHealthBar(graphic:Class, xOffset:int):FlxBar {
			var scoreBar:FlxBar = new FlxBar(StaticVars.TANK_X + xOffset, StaticVars.TANK_Y + 50,FlxBar.FILL_LEFT_TO_RIGHT, 158, 14);
			scoreBar.createImageBar(null, graphic, 0x0);
			scoreBar.setRange(0, 10);
			return scoreBar;
		}
		
		public static function addKillBar():FlxSprite {
			var killBar:FlxSprite = new FlxSprite(StaticVars.KILLBAR_X, StaticVars.KILLBAR_Y);
			killBar.makeGraphic(510, 5, StaticVars.INVISIBLE);
			//killBar.offset = new FlxPoint(0, StaticVars.objOffset);
			return killBar;
		}
		
		//////////////////// land background ////////////////////////////////
		public static function landBackground():FlxSprite {
			return new FlxSprite(0, 0, Img.landBackground);
		}
		
		public static function seaBackground():FlxSprite {
			return new FlxSprite(0, 0, Img.seaBackground);
		}
		
		public static function airBackground():FlxSprite {
			return new FlxSprite(0, 0, Img.airBackground);
		}
	}
	

}