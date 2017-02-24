package managers.baoziwang
{
	import laya.maths.Rectangle;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	public class MainPanelTop extends Box
	{
		private var recordList:List;
		private var recordListBox:Box;
		private var recordArr:Array;
		private var tempImage:Image;
		public function MainPanelTop()
		{
			super();
		}
		
		public function init():void
		{
			recordListBox = getChildByName("recordListBox") as Box;
			recordList = recordListBox.getChildByName("recordList") as List;
			recordListBox.scrollRect = new Rectangle(0,0,180,26);
		}
		
		public function recordInit(arr:Array):void
		{
			recordArr = arr;
			freshRecord();
		}
		
		public function pushRecord(result:int):void
		{
			if(!tempImage)
			{
				tempImage = new Image(getRecordSkin(result));
				tempImage.pivotX = tempImage.x = tempImage.width/2;
				tempImage.pivotY = tempImage.y = tempImage.height/2;
				tempImage.visible = false;
				recordListBox.addChild(tempImage);
			}
			else
			{
				tempImage.skin = getRecordSkin(result);
			}
			Tween.to(recordList,{x:30},100,null,Handler.create(this,showNewRecord),4000,true);
		}
		
		private function showNewRecord():void
		{
			tempImage.visible = true;
			tempImage.scaleX = tempImage.scaleY = 1.5;
			Tween.to(tempImage,{scaleX:1,scaleY:1},100,null,Handler.create(this,showNewRecordEnd),0,true);
		}
		
		private function showNewRecordEnd():void
		{
			freshRecord();
		}
		
		private function freshRecord():void
		{
			Tween.clearTween(recordList);
			recordList.x = 0;
			if(tempImage)tempImage.visible = false;
			var i:int;
			for(i = 0; i < recordList.cells.length; i++)
			{
				var recordImage:Image = recordList.cells[i] as Image;
				var record:Object = recordArr[i];
				if(!record)
				{
					recordImage.visible = false;
				}
				else
				{
					recordImage.visible = true;
					recordImage.skin = getRecordSkin(record.cbResult);
				}
			}
		}
		
		private function getRecordSkin(result:int):String
		{
			var skin:String = "ui/baseUI/yb_bj_zs_01.png";
			switch(result)
			{
				case BaoziwangDefine.RESULT_SMALL:
					skin = "ui/baseUI/yb_bj_zs_01.png";
					break;
				case BaoziwangDefine.RESULT_BIG:
					skin = "ui/baseUI/yb_bj_zs_02.png";
					break;
				case BaoziwangDefine.RESULT_BAOZI:
					skin = "ui/baseUI/yb_bj_zs_03.png";
					break;
			}
			return skin;
		}
	}
}