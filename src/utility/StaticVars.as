package utility 
{
	/**
	 * ...
	 * @author Sam Wilson
	 */
	public class StaticVars 
	{
		public static const WIDTH:int = 510;
		public static const HEIGHT:int = 640;
		
		
		// kill bar
		public static const KILLBAR_X:int = 0;
		public static const KILLBAR_Y:int = 580;
		
		// health
		public static const TOTAL_HEALTH:int = 5;
		
		// level 1
		public static const _1_TOTAL_OBJ:int = 12;
		public static const _1_FALL_RATE:int = 50;
		// level 2
		public static const _2_TOTAL_OBJ:int = 15;
		public static const _2_FALL_RATE:int = 55;
		// level 3
		public static const _3_TOTAL_OBJ:int = 20;
		public static const _3_FALL_RATE:int = 60;
		// level 4
		public static const _4_TOTAL_OBJ:int = 20;
		public static const _4_FALL_RATE:int = 60;
		// level 5
		public static const _5_TOTAL_OBJ:int = 20;
		public static const _5_FALL_RATE:int = 60;
		public static const _5_TOTAL_HEALTH:int = 3;
		// level 6
		public static const _6_TOTAL_OBJ:int = 30;
		public static const _6_FALL_RATE:int = 30;
		
		// level 10
		public static const _10_FOOD_ALPHA:Number = 0.01;
		public static const _10_TOTAL_OBJ:int = 10;
		public static const _10_HUNGRY:int = 1000;
		public static const _10_DROP_COUNT:int = 100;
		
		// transportation
		public static const TRUCK_X:int = 30;
		public static const TRUCK_Y:int = 5;
		public static const PLANE_X:int = 30;
		public static const PLANE_Y:int = 5;
		public static const SHIP_X:int = WIDTH / 2 - 60;
		public static const SHIP_Y:int = 5;
		// buckets
		public static const TWO_BUCKETS:int = 2;
		public static const THREE_BUCKETS:int = 3;
		public static const BUCKET_X:int = WIDTH/2-50;
		public static const BUCKET_Y:int = 500;
		
		// fish
		public static const FISH_X:int = WIDTH / 2 - 35;
		public static const FISH_Y:int = 550;
		// lost text
		public static const LOST_TEXT_ALPHA:Number = 0.005;
		// fog
		public static const fogXPos:int = 0;
		public static const fogYPos:int = 130;
		
		
		// play button
		public static const PLAY_W:int = 200;
		public static const PLAY_H:int = 100; 
		public static const PLAY_BTN_X:int = 220;
		public static const PLAY_BTN_y:int = 100;
		
		public static const WHITE:int = 0xffffff;
		public static const BLACK:int = 0x11111111;
		public static const RED:int = 0xFFFF0000;
		public static const GREEN:int = 0xFF00FF00;
		public static const YELLOW:int = 0xFFFF00;
		public static const BLUE:int = 0xFF0000FF;
		public static const INVISIBLE:int = 0x00FFFFFF;
		public static const GREY:int = 0xFFAAAAAA;
		public static const BGCOLOR:int = 0xEEEEEEEE;
		
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
		
		public static var speed:int = 500;
		public static const BUCKET_LEFT:int = 5;
		public static const BUCKET_RIGHT:int = 405;
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
		public static const aPass:Number = 0.7;
		// level 1
		public static const a1MaxScore:int = 30;
		public static const a1Interval:int = 40;
		public static const _1MaxMiss:int = 10;
		// level 2
		public static const a2MaxScore:int = 30;
		public static const a2Interval:int = 35;
		public static const a2BombRate:int = 10;
		// level 3
		public static const a3MaxScore:int = 30;
		public static const a3Interval:int = 30;
		public static const a3BombRate:int = 7;
		public static const a3BombScore:int = 2;
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
		// bonus level 6
		public static const a6Time:int = 60000;
		public static const a6MaxScore:int = 10;
		public static const a6Interval:int = 20;
		public static const a6BombScore:int = 1;
		public static const a6AmmoNum:int = 20;
		
		// b fog theme:
		public static const bTime:int = 30000;
		public static const bPass:Number = 0.5;
		public static const fogRate:int = 100;
		
		public static const fogSpeed:int = -10;
		// level 1
		public static const b1MaxScore:int = 25;
		public static const b1Interval:int = 35;
		public static const b1BombRate:int = 10;
		public static const b1FogYPos:int = 50;
		public static const b1BombScore:int = 1;
		// level 2
		public static const b2MaxScore:int = 30;
		public static const b2Interval:int = 30;
		public static const b2Alpha:Number = 0.02;
		public static const b2FogYPos:int = 100;
		public static const b2BombRate:int = 7;
		public static const b2BombScore:int = 2;
		// level 3
		public static const b3MaxScore:int = 30;
		public static const b3Interval:int = 25;
		public static const b3Alpha:Number = 0.015;
		public static const b3BombRate:int = 5;
		public static const b3BombScore:int = 3;
		public static const b3AmmoNum:int = 10;
		public static const b3FogRate:int = 170;
		// level 4
		public static const b4MaxScore:int = 30;
		public static const b4Interval:int = 20;
		public static const b4Alpha:Number = 0.01;
		public static const b4BombRate:int = 4;
		public static const b4BombScore:int = 4;
		public static const b4AmmoNum:int = 20;
		public static const b4FogSpeed:int = -15;
		public static const b4FogRate:int = 500;
		// level 5
		public static const b5MaxScore:int = 40;
		public static const b5Time:int = 45000;
		public static const b5Interval:int = 20;
		public static const b5Alpha:Number = 0.01;
		public static const b5FogYPos:int = 150;
		public static const b5BombRate:int = 3;
		public static const b5BombScore:int = 5;
		public static const b5AmmoNum:int = 25;
		public static const b5FogSpeed:int = -30;
		public static const b5FogMove:int = 250;
		
		// c recycle theme
		public static const cTime:int = 40000;
		public static const cPass:Number = 0.6;
		
		// level 1
		public static const c1MaxScore:int = 40;
		public static const c1Interval:int = 30;
		// level 2
		public static const c2MaxScore:int = 30;
		public static const c2Interval:int = 25;
		public static const c2BombScore:int = 1;
		// level 3
		public static const c3MaxScore:int = 40;
		public static const c3Interval:int = 20;
		public static const c3BombScore:int = 2;
		public static const c3BombRate:int = 10;
		// level 4
		public static const c4MaxScore:int = 40;
		public static const c4Interval:int = 20;
		public static const c4Alpha:Number = 0.02;
		public static const c4FogRate:int = 120;
		// level 5
		public static const c5MaxScore:int = 40;
		public static const c5Interval:int = 20;
		public static const c5BombScore:int = 4;
		public static const c5Alpha:Number = 0.015;
		public static const c5FogRate:int = 150;
		public static const c5BombRate:int = 10;
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
		
		public static var logger:Logger = new Logger("trash_it", 108, "83dcd169ecb97a898ee94c90441696cd",1, 2);
	}
	
	

}