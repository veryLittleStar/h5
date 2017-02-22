package managers.baoziwang
{
	import laya.display.Animation;
	import laya.events.Event;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class LaoPaoWang extends Animation
	{
		private var motion:String;
		public function LaoPaoWang()
		{
			super();
			this.on(Event.COMPLETE,this,motionComplete);
		}
		
		public function init():void
		{
			
		}
		
		public function reset():void
		{
			changeMotion("idle",true);
		}
		
		public function changeMotion(motion:String,loop:Boolean):void
		{
			this.motion = motion;
			this.source = "ani/yb_rdh_" + motion+".ani";
			this.play(0,loop);
			if(motion == "yao")
			{
				scaleX = scaleY = 0.5;
				x = 404;y = 133;
//				Tween.to(this,{x:405,y:133,scaleX:1,scaleY:1},200,null);
//				Tween.to(this,{scaleX:0.5,scaleY:0.5},200,null,Handler.create(this,yaoComplete),2000);
			}
		}
		
		private function motionComplete(event:Event):void
		{
			if(motion == "yao")
			{
				changeMotion("idle",true);
				scaleX = scaleY = 1;
				x = 411;y = 125;
			}
			if(motion == "open")
			{
				Laya.timer.once(4000,this,changeMotion,["close",false]);
			}
			if(motion == "close")
			{
				changeMotion("idle",true);
			}
		}
		
		private function yaoComplete():void
		{
			
		}
	}
}