import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldType;
import openfl.display.FPS;
import wx.App;
import wx.Button;
import wx.EventID;
import wx.FileDialog;
import wx.Frame;
import wx.NMEStage;
import wx.Sizer;
import flash.events.Event;
import flash.events.MouseEvent;

class WaxeMe
{
   var mFrame : Frame;
   var mStage : NMEStage;
   var tf:TextField; 
   
   function new()
   {
      mFrame = Frame.create(null,"NME Frame");
      var count = 0;

      var me = this;
      mFrame.onSize = function(evt) { me.layout(); evt.skip=true; }

      mStage = NMEStage.create(mFrame,null,null,{width:300,height:300});

      var s = new Sprite();
      var gfx = s.graphics;
      gfx.beginFill(0xff0000);
      gfx.drawRect(0, 0, 200, 100);
	  gfx.endFill();
      mStage.stage.addChild(s);
      mStage.stage.frameRate = 10;
      mStage.stage.addChild( new FPS(10,10) );
      s.addEventListener(MouseEvent.MOUSE_OVER, function(_) trace("Over!") );
      s.addEventListener(MouseEvent.MOUSE_DOWN, function(_) trace("Down!") );
      s.addEventListener(MouseEvent.MOUSE_UP, function(_) trace("Up!") );
      mStage.stage.addEventListener(MouseEvent.MOUSE_MOVE, function(e) trace("Move:" + e.localX+","+e.localY) );
      //s.addEventListener(Event.ENTER_FRAME, function(_) s.x = (s.x + 1) % 200 );
	  s.addEventListener(MouseEvent.CLICK, function(_) { trace("CLICK!"); onClicky(null); } );
	  //s.addEventListener(MouseEvent.CLICK, onClicky, false, 0, true);

	  tf = new TextField();
      tf.text = "Click the red square to show a file";
      tf.type = TextFieldType.INPUT;
	  tf.width = 800;
      tf.x = 20;
      tf.y = 200;
      mStage.stage.addChild(tf);

      App.setTopWindow(mFrame);
      mFrame.shown = true;	  
	  
	  entryPoint();
   }

   function layout()
   {
      mStage.size = mFrame.clientSize;
   }
   
   public function entryPoint():Void {
	   /*var button:Button = Button.create(mFrame, null, "Open a JPG or PNG");
	   button.onClick = showFileDialog;*/
	   /*var up:Shape = new Shape(); up.graphics.beginFill(0x888888); up.graphics.drawRect(0, 0, 64, 32); up.graphics.endFill();
	   var over:Shape = new Shape(); over.graphics.beginFill(0xaaaaaa); over.graphics.drawRect(0, 0, 64, 32); over.graphics.endFill();
	   var down:Shape = new Shape(); down.graphics.beginFill(0x555555); down.graphics.drawRect(0, 0, 64, 32); down.graphics.endFill();
	   var hit:Shape = new Shape(); hit.graphics.beginFill(0x888888); hit.graphics.drawRect(0, 0, 64, 32); hit.graphics.endFill();
	   var s:SimpleButton = new SimpleButton(up, over, down, hit);
	   s.addEventListener(MouseEvent.CLICK, onClicky, false, 0, true);
	   mStage.stage.addChild(s);
	   
	   mStage.stage.addEventListener(MouseEvent.CLICK, onClicky, false, 0, true);*/
   }
   
   private function onClicky(m:MouseEvent):Void {
	   showFileDialog(m);
   }
   
   public function showFileDialog(event:Dynamic):Void {
	   var fileDialog:FileDialog = new FileDialog(mFrame, "Choose an image" , "" , "" , "PNG and JPG files|*.png;*.jpg|PNG files|*.png|JPG files|*.jpg");
	   if (fileDialog.showModal()) {
		   trace("Selected");
		   /*trace("Dir = " + fileDialog.directory);
		   trace("File = " + fileDialog.file);
		   trace("Files = " + fileDialog.files);*/
		   tf.text = fileDialog.directory + "/" + fileDialog.file;
	   }else {
		   trace("Cancelled");
	   }
   }

   public static function main()
   {
	  App.boot( function(){ new WaxeMe(); } );
   }
}
