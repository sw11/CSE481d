package main 
{
	import org.flixel.*;
	import utility.*;
	import a_basic_theme.*;
	import b_recycle_theme.*;
	/**
	 * ...
	 * @author Adrian
	 */
	public class EndState extends FlxState
	{
		//public var nextStage : Number;
		private var result:String;
		private var score:int;
		private var miss:int;
		private var yPos:int;
		
		
		public function EndState(result:String, score:int, miss:int): void {
			super();
			this.result = result;
			this.score = score;
			this.miss = miss;
			yPos = 100;
			//State.unlockLevel = level;
		}
		
		override public function create(): void {
			/*var winnerText:FlxText;
			winnerText = new FlxText(0, yPos += 40, FlxG.width, result);
			winnerText.setFormat(null, 16, StaticVars.BLACK, "center");
			add(winnerText);*/
			addText(result);
			
			addText("Score: " + score);
			
			addText("Miss: " + miss);
			// todo
			// add score summary points
			addText("Press ENTER to continue");
			
			/*var instruction:FlxText;
			instruction = new FlxText(0, 100, FlxG.width, "Press ENTER to continue");
			instruction.setFormat(null, 16, StaticVars.BLACK, "center");
			add(instruction);
			*/
		}
		
		private function addText(str:String):void {
			var text:FlxText;
			text = new FlxText(0, yPos += 40, FlxG.width, str);
			text.setFormat(null, 16, StaticVars.BLACK, "center");
			add(text);
		}
		
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed("ENTER")) {
				/*var currTheme:int = State.unlockTheme;
				if (State.unlockLevel == 7) {
					if (State.unlockTheme + 1 == 5) {
						State.unlockTheme = 4;
					} else {
						State.unlockTheme ++;
					}
					State.unlockLevel = 1;
				} else {
					State.unlockLevel ++;
				}*/
				FlxG.switchState(new LevelState(State.unlockTheme));
				///LostState.changeState(nextStage);
			}
		}
	}

}