package ;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.system.Capabilities;
import flash.text.TextField;
import flash.text.TextFieldType;

/**
 * ...
 * @author larsiusprime
 */

class Main extends Sprite 
{
	var inited:Bool;
	var modes:Array<flash.system.ScreenMode>;
	var textSelected:TextField;
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		var text:TextField = new TextField();
		text.textColor = 0xFFFFFF;
		text.width = 400;
		text.height = 1080;
		addChild(text);
		
		textSelected = new TextField();
		textSelected.textColor = 0xFFFFFF;
		textSelected.width = 400;
		textSelected.x = text.x + text.width + 5;
		textSelected.text = "0";
		addChild(textSelected);
		
		var instructions = new TextField();
		instructions.textColor = 0xFFFFFF;
		instructions.width = 400;
		instructions.x = textSelected.x;
		instructions.y = textSelected.y + 50;
		instructions.text = "Press + and - on keyboard to select mode, Enter to change";
		
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginFill(0xFFFFFF);
		sprite.graphics.drawRect(0, 0, 50, 25);
		sprite.graphics.endFill();
		
		var butt:SimpleButton = new SimpleButton(sprite);
		butt.x = textSelected.x;
		butt.y = textSelected.y + textSelected.height + 5;
		butt.width = textSelected.width;
		butt.height = textSelected.height;
		addChild(butt);
		
		stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		
		modes = Capabilities.screenModes;
		
		var i:Int = 0;
		
		for (mode in modes) {
			text.text += "Mode " + i + ": (" + mode.width + "," + mode.height + ") @ " + mode.refreshRate + " Hz, format = " + mode.format + "\n";
			trace("Mode " + i + ": (" + mode.width + "," + mode.height + ") @ " + mode.refreshRate + " Hz, format = " + mode.format);
			i++;
		}
	}

	
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function onKeyDown(e:KeyboardEvent):Void {
		switch(e.charCode) {
			case 45:
				addInput(-1);
			case 61:
				addInput(1);
			case 13:
				var i:Int = Std.parseInt(textSelected.text);
				if(i >= 0 && i < modes.length){
					stage.setScreenMode(modes[i]);
				}
		}
	}
	
	function addInput(i:Int):Void {
		var val:Int = Std.parseInt(textSelected.text);
		val += i;
		textSelected.text = Std.string(val);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
