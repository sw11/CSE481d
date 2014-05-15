package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class StaticVars 
	{
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 640;
		
		// play button
		public static const PLAY_W:int = 200;
		public static const PLAY_H:int = 100; 
		public static const PLAY_BTN_X:int = 220;
		public static const PLAY_BTN_y:int = 100;
		
		/* setting button 
		public static const SETTING_W:int =  200;
		public static const SETTING_H:int =  100; 
		public static const SETTING_BTN_X:int = 220;
		public static const SETTING_BTN_y:int = 300;
		*/
		public static const WHITE:int = 0xffffff;
		public static const BLACK:int = 0x11111111;
		public static const RED:int = 0xFFFF0000;
		public static const GREEN:int = 0xDEA543;
		public static const YELLOW:int = 0xFFFF00;
		public static const INVISIBLE:int = 0x00FFFFFF;
		
		/*public static const SETTING_BUTTON_X:int = 15;
		public static const SETTING_BUTTON_Y:int = 15;
		public static const SETTING_SIZE_X:int = 100;
		public static const SETTING_SIZE_Y:int = 100;
		*/
		public static const A_THEME:int = 1;
		public static const B_THEME:int = 2;
		public static const C_THEME:int = 3;
		public static const D_THEME:int = 4;
		
		// lane x position
		public static const lane1:int = 130;
		public static const lane2:int = 230;
		public static const lane3:int = 330;
		public static const lane4:int = 430;
		public static const lane5:int = 530;
		public static const lanes:Array = new Array(lane1, lane2, lane3, lane4, lane5);
		
		// bucket
		public static const bucket_x:int = 130;
		public static const bucket_y:int = 525;
		public static var speed:int = 450;
		// bomb
		public static const bombOffSet:int = 25;
		// fall objects
		public static const objOffset:int = -50;
		public static const yOffset:int = -100;
		public static const fallSpeedSlow:int = 150;
		public static const fallSpeedMid:int = 200;
		public static const fallSpeedFast:int = 250;
		public static const fallSpeedSuper:int = 300;
		public static const speedOffset:int = 50;
		// a basic theme:
		public static const aTime:int = 35000;
		public static const aPass:Number = 0.6;
		// level 1
		public static const a1MaxScore:int = 30;
		public static const a1Interval:int = 40;
		// level 2
		public static const a2MaxScore:int = 35;
		public static const a2Interval:int = 35;
		public static const a2BombRate:int = 10;
		// level 3
		public static const a3MaxScore:int = 35;
		public static const a3Interval:int = 30;
		public static const a3BombRate:int = 7;
		public static const a3BombScore:int = 5;
		// level 4
		public static const a4MaxScore:int = 20;
		public static const a4Interval:int = 25;
		public static const a4BombRate:int = 3;
		public static const a4BombScore:int = 5;
		// level 5
		public static const a5MaxScore:int = 20;
		public static const a5Interval:int = 20;
		public static const a5BombRate:int = 2;
		public static const a5BombScore:int = 2;
		public static const a5AmmoNum:int = 10;
		// level 6
		public static const a6Time:int = 60000;
		public static const a6MaxScore:int = 10;
		public static const a6Interval:int = 20;
		public static const a6BombScore:int = 1;
		public static const a6AmmoNum:int = 20;
		
		// b recycle theme:
		public static const bTime:int = 60000;
		public static const bPass:Number = 0.5;
		public static const NUM_BUCKET:int = 3;
		// level 1
		public static const b1MaxScore:int = 45;
		public static const b1Interval:int = 35;
		// level 2
		public static const b2MaxScore:int = 50;
		public static const b2Interval:int = 30;
		// level 3
		public static const b3MaxScore:int = 60;
		public static const b3Interval:int = 20;
		
		
		// d bomb theme
		public static const dTime:int = 60000;
		public static const dPass:Number = 0.6;
		// level 10
		public static const d10MaxScore:int = 70;
		public static const d10Interval:int = 35;
		// level 11
		public static const d11MaxScore:int = 60;
		public static const d11Interval:int = 25;
		// level 12
		public static const d12MaxScore:int = 50;
		public static const d12Interval:int = 15;
	}
	
	

}