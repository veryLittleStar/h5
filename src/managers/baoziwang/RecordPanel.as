package managers.baoziwang
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.List;
	
	public class RecordPanel extends Box
	{
		private var recordList:List;
		public function RecordPanel()
		{
			super();
		}
		
		public function init():void
		{
			this.visible = false;
			recordList = getChildByName("recordList") as List;
		}
		
		public function openMe(arr:Array):void
		{
			this.visible = true;
			Laya.stage.on(Event.MOUSE_UP,this,stageMouseUp);
			for(var i:int = 0;i < arr.length; i++)
			{
				arr[i].arIndex = i;
			}
			recordList.array = arr;
		}
		
		public function closeMe():void
		{
			this.visible = false;
			Laya.stage.off(Event.MOUSE_UP,this,stageMouseUp);
		}
		
		private function stageMouseUp(event:Event = null):void
		{
			if(this.hitTestPoint(event.stageX,event.stageY))
			{
				
			}
			else
			{
				closeMe();
			}
		}
	}
}