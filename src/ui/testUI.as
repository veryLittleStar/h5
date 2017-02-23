/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class testUI extends View {

		public static var uiView:Object ={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Box","props":{"y":-33,"x":3},"child":[{"type":"Image","props":{"y":-14,"x":1,"width":330,"skin":"ui/baseUI/ttz_talk_bg_1.png","sizeGrid":"0,52,0,0"}},{"type":"Image","props":{"y":134,"x":303,"skin":"ui/baseUI/ttz_talk_txt_01.png"}},{"type":"Image","props":{"y":231,"x":304,"skin":"ui/baseUI/ttz_talk_txt_02.png"}},{"type":"Image","props":{"y":274,"x":306,"width":12,"skin":"ui/baseUI/ttz_talk_j2.png","height":12}},{"type":"Image","props":{"y":179,"x":304,"skin":"ui/baseUI/ttz_talk_j2.png"}},{"type":"Image","props":{"y":-2,"x":8,"width":279,"skin":"ui/baseUI/ttz_talk_bg_3.png","sizeGrid":"10,10,10,10","height":417}}]},{"type":"Image","props":{"y":4,"x":12,"width":266,"skin":"ui/baseUI/ttz_wzwj_1.png","sizeGrid":"20,15,15,20","height":56}},{"type":"Image","props":{"y":-40,"x":377,"width":284,"skin":"ui/baseUI/game_phb_10.png","sizeGrid":"20,20,25,20","height":500}},{"type":"Image","props":{"y":10,"x":385,"width":269,"skin":"ui/baseUI/yb_sz_ls_lv2.png","sizeGrid":"15,30,15,30","height":49}},{"type":"Image","props":{"y":23,"x":591,"skin":"ui/baseUI/yb_sz_ls_11.png"}},{"type":"Image","props":{"y":19,"x":613,"skin":"ui/baseUI/yb_bj_zs_01.png"}},{"type":"Image","props":{"y":11,"x":390,"skin":"ui/baseUI/ttz_sezi_d_1.png"}},{"type":"Image","props":{"y":11,"x":438,"skin":"ui/baseUI/ttz_sezi_d_1.png"}},{"type":"Image","props":{"y":11,"x":483,"skin":"ui/baseUI/ttz_sezi_d_1.png"}},{"type":"Label","props":{"y":33,"x":546,"text":"label"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}