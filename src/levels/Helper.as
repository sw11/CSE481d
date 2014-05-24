package levels 
{
	import fall_object.FallingObj;
	import fall_object.FallObjs;
	import org.flixel.*;
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
			/*if (passText != null) {
				passText.alpha = passText.alpha - 0.005;
				if (passText.alpha <= 0) {
					passText.kill();
					//passText = null;
				}
			}*/
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
		
		public static function endGame(data:Object): void {
			var score:int = data["score"];
			var miss:int = data["miss"];
			var bonus:int = data["bonus"];
			var maxScore:int = data["maxScore"];
			var level:int = data["level"];
			var passScore:int = data["passScore"];
			//trace("level " + level + " miss " + miss);
			//trace(score);
			//var perfect:Number = maxScore * StaticVars.aPerf;
			if (score >= passScore) {
				//trace("in end game() theme " + StaticVars.A_THEME + " level " + level);
				if (level == State.unlockLevel) {
					State.nextLevel();
				}
				FlxG.switchState(new EndState("WIN", score, miss, bonus, maxScore, StaticVars.A_THEME, level));
			} else {
				FlxG.switchState(new EndState("LOSE", score, miss, bonus, maxScore, StaticVars.A_THEME, level));	
			}
		}
		
		public static function endgame(data:Object): void {
			//var score:int = data["score"];
			//var miss:int = data["miss"];
			//var bonus:int = data["bonus"];
			//var maxScore:int = data["maxScore"];
			var level:int = data["level"];
			//var passScore:int = data["passScore"];
			var health:int = data["health"];
			//trace("level " + level + " miss " + miss);
			//trace("level " + level + " health " + health + " unlocklevel " + State.unlockLevel);
			//var perfect:Number = maxScore * StaticVars.aPerf;
			if (health > 0) {
				// win
				if (level == State.unlockLevel) {
					State.toNextLevel();
				}
				FlxG.switchState(new FinishState("WIN", health, level));
			} else {
				// lost
				FlxG.switchState(new FinishState("LOST", health, level));
			}
			/*
			if (score >= passScore) {
				//trace("in end game() theme " + StaticVars.A_THEME + " level " + level);
				if (level == State.unlockLevel) {
					State.nextLevel();
				}
				FlxG.switchState(new EndState("WIN", score, miss, bonus, maxScore, StaticVars.A_THEME, level));
			} else {
				FlxG.switchState(new EndState("LOSE", score, miss, bonus, maxScore, StaticVars.A_THEME, level));	
			}*/
		}
		
		///////////////////////////// Fall objects /////////////////////////////////
		public static function fallObject(lane:int, yOffset:int, speed:int, isRecycle:Boolean):FallingObj {
			var obj:FallingObj = new FallingObj(lane, yOffset, isRecycle);
			obj.velocity.y = speed;
			obj.alpha = 0.99;
			return obj;
		}
		
		// new one
		public static function fallObj(lane:int, yOffset:int, speed:int, whichObj:int):FallObjs {
			var obj:FallObjs = new FallObjs(lane, 0, whichObj);
			obj.velocity.y = speed;
			return obj
		}
		
		public static function addInstr(text:String, xPos:int, yPos:int, color:int, fontSize:int):FlxText {
			var str:FlxText = new FlxText(xPos, yPos, FlxG.width, text);
			str.setFormat(null, fontSize, color, "center");
			return str;
		}
	}

}