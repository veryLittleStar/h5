package managers.baoziwang
{
	import customUI.BmpFontLabel;
	
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class DiceCupBox extends Box
	{
		private var diceCtn:Box = new Box();
		private var diceArr:Array = [];
		private var cap:Image;
		private var tray:Image;
		private var light:Image;
		private var numLabel:BmpFontLabel;
		private var point:Image;
		private var dx:Image;
		private var pointBox:Image;
		
		private var totalNum:int;
		private var baozi:Boolean = false;
		public function DiceCupBox()
		{
			super();
		}
		
		public function init():void
		{
			light = getChildByName("light") as Image;
			cap = getChildByName("cap") as Image;
			tray = getChildByName("tray") as Image;
			pointBox = getChildByName("pointBox") as Image;
			numLabel = pointBox.getChildByName("numLabel") as BmpFontLabel;
			point = pointBox.getChildByName("point") as Image;
			dx = pointBox.getChildByName("dx") as Image;
		}
		
		public function reset():void
		{
			Tween.clearAll(this);
			Tween.clearAll(light);
			Tween.clearAll(cap);
			Tween.clearAll(numLabel);
			Tween.clearAll(point);
			Tween.clearAll(dx);
			Tween.clearAll(diceCtn);
			Laya.timer.clearAll(this);
			this.visible = false;
			diceCtn.removeSelf();
		}
		
		private function prepare():void
		{
			light.visible = false;
			cap.rotation = 0;
			cap.x = 0;
			cap.y = 0;
			this.scaleX = this.scaleY = 0.2;
			this.y = 250;
			this.visible = true;
			this.alpha = 1;
			pointBox.visible = false;
			diceCtn.scaleX = diceCtn.scaleY = 1;
		}
		
		public function openDiceCup(diceNumArr:Array):void
		{
			reset();
			prepare();
			baozi = false;
			totalNum = diceNumArr[0] + diceNumArr[1] + diceNumArr[2];
			numLabel.text = String(totalNum);
//			numLabel.x = totalNum < 10 ?-45:-60;
			if(diceNumArr[0] == diceNumArr[1] && diceNumArr[1] == diceNumArr[2])
			{//豹子
				baozi = true;
			}
			else
			{
				
				if(totalNum <= 10)
				{//小
					
				}
				else
				{//大
					
				}
			}
			var posX:int = 0;
			var posY:int = 0;
			for(var i:int = 0; i < 3; i++)
			{
				var dice:Image = diceArr[i];
				if(!dice)
				{
					dice = new Image();
					diceArr[i] = dice;
					diceCtn.addChild(dice);
				}
				dice.skin = getDiceSkin(diceNumArr[i],false);
				dice.x = posX;
				posX += dice.width + 2;
				posY = dice.height;
				trace(dice.x,dice.y);
			}
			tray.addChild(diceCtn);
			diceCtn.x = (tray.width - posX)/2;
			diceCtn.y = (tray.height - 50)/2 - 5;
			
			Tween.to(this,{scaleX:1,scaleY:1,y:330},200,null,Handler.create(this,step1),0,true);
		}
		
		private function step1():void
		{
			Laya.timer.once(700,this,step2);
		}
		
		private function step2():void
		{
			light.visible = true;
			light.scaleX = 0;
			Tween.to(light,{scaleX:2.5},500,null,null,0,true);
			Tween.to(cap,{x:-300,y:-400,rotation:-25},700,null,null,0,true);
			Laya.timer.once(500,this,step3);
		}
		
		private function step3():void
		{
			var tempP:Point = new Point(0,0);
			tempP = diceCtn.localToGlobal(tempP);
			diceCtn.x = tempP.x;
			diceCtn.y = tempP.y;
			Laya.stage.addChild(diceCtn);
			pointBox.visible = true;
			numLabel.scaleX = numLabel.scaleY = point.scaleX = point.scaleY = dx.scaleX = dx.scaleY = 0;
			Tween.to(numLabel,{scaleX:1,scaleY:1},500,Ease.backOut);
			Tween.to(point,{scaleX:1,scaleY:1},500,Ease.backOut,null,150);
			Tween.to(dx,{scaleX:1,scaleY:1},500,Ease.backOut,null,300);
			Laya.timer.once(2000,this,step4);
		}
		
		private function step4():void
		{
			Tween.to(this,{alpha:0},1000,null,Handler.create(this,step5),0,true);
		}
		
		private function step5():void
		{
			this.visible = false;
			if(baozi)
			{
				Tween.to(diceCtn,{scaleX:0.5,scaleY:0.5,x:375,y:250},500);
			}
			else
			{
				if(totalNum < 10)
				{
					Tween.to(diceCtn,{scaleX:0.5,scaleY:0.5,x:175,y:250},500);
				}
				else
				{
					Tween.to(diceCtn,{scaleX:0.5,scaleY:0.5,x:575,y:250},500);
				}
			}
			Laya.timer.once(3000,this,step6);
		}
		
		private function step6():void
		{
			diceCtn.removeSelf();
		}
		
		private function getDiceSkin(num:int,baozi:Boolean):String
		{
			if(baozi)
			{
				return "ui/baseUI/yb_sz_j"+num+".png";
			}
			else
			{
				if(Math.random()<0.5)
				{
					return "ui/baseUI/ttz_sezi_"+num+".png";
				}
				else
				{
					return "ui/baseUI/ttz_sezi_"+num+"_1.png";
				}
			}
		}
	}
}