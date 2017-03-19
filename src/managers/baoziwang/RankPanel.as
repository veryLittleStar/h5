package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.ui.Tab;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	import managers.gameLogin.GameLoginDefine;
	
	import net.NetProxy;
	
	public class RankPanel extends Box
	{
		private var bgImage:Image;
		
		private var personalArrow:Image;
		private var todayArrow:Image;
		private var yesterdayArrow:Image;
		
		private var personalBtn:Box;
		private var todayBtn:Box;
		private var yesterdayBtn:Box;
		
		private var personalBox:Box;
		private var personalList:List;
		
		private var todayBox:Box;
		private var todayTab:Tab;
		private var todayWinList:List;
		private var todayLoseList:List;
		
		private var yesterdayBox:Box;
		private var yesterdayTab:Tab;
		private var yesterdayWinList:List;
		private var yesterdayLoseList:List;
		
		private var _showState:int = 0;
		private var _choseState:int = 0;
		
		public var rankReqThisRound:Boolean = false;
		public function RankPanel()
		{
			super();
		}
		
		public function init():void
		{
			bgImage = getChildByName("bgImage") as Image;
			
			personalArrow = getChildByName("personalArrow") as Image;
			todayArrow = getChildByName("todayArrow") as Image;
			yesterdayArrow = getChildByName("yesterdayArrow") as Image;
			
			personalBtn = getChildByName("personalBtn") as Box;
			todayBtn = getChildByName("todayBtn") as Box;
			yesterdayBtn = getChildByName("yesterdayBtn") as Box;
			
			personalBox = getChildByName("personalBox") as Box;
			personalList = personalBox.getChildByName("personalList") as List;
			
			todayBox = getChildByName("todayBox") as Box;
			todayTab = todayBox.getChildByName("tabBtn") as Tab;
			todayWinList = todayBox.getChildByName("winList") as List;
			todayLoseList = todayBox.getChildByName("loseList") as List;
			
			yesterdayBox = getChildByName("yesterdayBox") as Box;
			yesterdayTab = yesterdayBox.getChildByName("tabBtn") as Tab;
			yesterdayWinList = yesterdayBox.getChildByName("winList") as List;
			yesterdayLoseList = yesterdayBox.getChildByName("loseList") as List;
			
			
			personalBtn.on(Event.CLICK,this,personClick);
			todayBtn.on(Event.CLICK,this,todayClick);
			yesterdayBtn.on(Event.CLICK,this,yesterdayClick);
			
			freshState();
			personalList.array = [];
			todayWinList.array = [];
			todayLoseList.array = [];
			yesterdayWinList.array = [];
			yesterdayLoseList.array = [];
			this.x = Laya.stage.width - 30;
			
			todayTab.selectHandler = Handler.create(this,todayTabSwitch,null,false);
			yesterdayTab.selectHandler = Handler.create(this,yesterdayTabSwitch,null,false);
			
			todayTabSwitch();
			yesterdayTabSwitch();
		}
		
		private function stageMouseUp(event:Event = null):void
		{
			if(this.hitTestPoint(event.stageX,event.stageY))
			{
				
			}
			else
			{
				showState = 0;
			}
		}
		
		private function personClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 0;
			}
			else
			{
				if(_choseState == 0)
				{
					showState = 0;
				}
				choseState = 0;
			}
		}
		
		private function todayClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 1;
			}
			else
			{
				if(_choseState == 1)
				{
					showState = 0;
				}
				choseState = 1;
			}
		}
		
		private function yesterdayClick(event:* = null):void
		{
			if(_showState == 0)
			{
				showState = 1;
				choseState = 2;
			}
			else
			{
				if(_choseState == 2)
				{
					showState = 0;
				}
				choseState = 2;
			}
		}
		
		private function set showState(value:int):void
		{
			if(_showState == value)return;
			_showState = value;
			freshState();
			if(_showState == 0)
			{
				Tween.to(this,{x:Laya.stage.width - 30},300,null,null,0,true);
				Laya.stage.off(Event.MOUSE_UP,this,stageMouseUp);
			}
			else
			{
				Tween.to(this,{x:Laya.stage.width - 30 - 295},300,null,null,0,true);
				Laya.stage.on(Event.MOUSE_UP,this,stageMouseUp);
				if(!rankReqThisRound)
				{
					NetProxy.getInstance().sendToServer(GameLoginDefine.MSG_USER_RANK_LIST_REQ,{});
				}
			}
		}
		
		private function set choseState(value:int):void
		{
			if(_choseState == value)return;
			_choseState = value;
			freshState();
		}
		
		private function freshState():void
		{
			if(_showState == 0)	//隐藏排行榜
			{
				personalArrow.skin = "ui/baseUI/ttz_talk_j2.png";
				todayArrow.skin = "ui/baseUI/ttz_talk_j2.png";
				yesterdayArrow.skin = "ui/baseUI/ttz_talk_j2.png";
			}
			else				//显示排行榜
			{
				personalArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				todayArrow.skin = "ui/baseUI/ttz_talk_j1.png";
				yesterdayArrow.skin = "ui/baseUI/ttz_talk_j1.png";
			}
			if(_choseState == 0)//选中个人榜
			{
				personalArrow.visible = true;
				todayArrow.visible = false;
				yesterdayArrow.visible = false;
				
				personalBox.visible = true;
				todayBox.visible = false;
				yesterdayBox.visible = false;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_0.png";
			}
			else if(_choseState == 1)//选中今日榜
			{
				personalArrow.visible = false;
				todayArrow.visible = true;
				yesterdayArrow.visible = false;
				
				personalBox.visible = false;
				todayBox.visible = true;
				yesterdayBox.visible = false;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_1.png";
			}
			else				//选中昨日榜
			{
				personalArrow.visible = false;
				todayArrow.visible = false;
				yesterdayArrow.visible = true;
				
				personalBox.visible = false;
				todayBox.visible = false;
				yesterdayBox.visible = true;
				bgImage.skin = "ui/baseUI/ttz_talk_bg_2.png";
			}
		}
		
		/**@param winScore:输赢数
		 * @param small:下注小的数目
		 * @param big:下注大的数目
		 * @param isBanker:是否坐庄*/
		public function updatePersonalRecord(obj:Object):void
		{
			if(obj.small == 0 && obj.big == 0 && obj.isBanker == false)
			{
				return;
			}
			Laya.timer.once(5000,this,addPersonalRecord,[obj],false);
		}
		
		private function addPersonalRecord(obj:Object):void
		{
			var date:Date = new Date();
			date.setTime(Browser.now());

			var min:int = date.getMinutes();
			var sec:int = date.getSeconds();
			var minStr:String;
			if(min < 10)
			{
				minStr = "0"+ min;
			}
			else
			{
				minStr = "" + min;
			}
			var secStr:String;
			if(sec < 10)
			{
				secStr = "0" + sec;
			}
			else
			{
				secStr = "" + sec;
			}
			obj.time = date.getHours() + ":" + minStr + ":" + secStr;
			personalList.addItem(obj);
			personalList.scrollTo(personalList.array.length);
		}
		
		private function todayTabSwitch():void
		{
			if(todayTab.selectedIndex == 0)
			{
				todayWinList.visible = true;
				todayLoseList.visible = false;
			}
			else
			{
				todayWinList.visible = false;
				todayLoseList.visible = true;
			}
		}
		
		private function yesterdayTabSwitch():void
		{
			if(yesterdayTab.selectedIndex == 0)
			{
				yesterdayWinList.visible = true;
				yesterdayLoseList.visible = false;
			}
			else
			{
				yesterdayWinList.visible = false;
				yesterdayLoseList.visible = true;
			}
		}
		
		public function updateRankInfo(obj:Object):void
		{
			//obj.cType 0赢钱  1输钱
			//obj.arRank
			//	obj.szNickName
			//	obj.lScore
			if(obj.cType == 0)
			{
				updateYesterdayWinRank(obj.arRank);
			}
			
			if(obj.cType == 1)
			{
				updateYesterdayLoseRank(obj.arRank);
			}
			
			if(obj.cType == 2)
			{
				rankReqThisRound = true;
				updateTodayWinRank(obj.arRank);
			}
			
			if(obj.cType == 3)
			{
				rankReqThisRound = true;
				updateTodayLoseRank(obj.arRank);
			}
		}
		
		private function updateYesterdayWinRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			yesterdayWinList.array = rankArr;
		}
		
		private function updateYesterdayLoseRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			yesterdayLoseList.array = rankArr;
		}
		
		private function updateTodayWinRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			todayWinList.array = rankArr;
		}
		
		private function updateTodayLoseRank(arr:Array):void
		{
			var rankArr:Array = [];
			var i:int;
			for(i = 0; i < arr.length; i++)
			{
				if(arr[i].szNickName != "")
				{
					arr[i].rankIndex = (i+1);
					rankArr.push(arr[i]);
				}
			}
			todayLoseList.array = rankArr;
		}
		
		
	}
}