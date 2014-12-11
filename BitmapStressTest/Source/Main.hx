package;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl._v2.geom.Matrix;
import openfl.Assets;
import openfl.events.Event;
import openfl.geom.ColorTransform;
import openfl.Lib;
import openfl.system.System;

/**
 * Clones the same bitmap over and over again and colorTransform()'s it until the program crashes
 */

class Main extends Sprite {
	
	public var elapsed:Float = 0;
	public var lastTime:Int = 0;
	
	public var waitUntil:Float = 0;
	public var wait:Float = 0.01;
	
	public var bitmap:Bitmap;
	public var phase:Int = 0;
	public var ct:ColorTransform;
	public var iterations:Int = 0;
	
	public function new () {
		trace("This program will mysteriously crash around iteration 38-40 or so.");
		lastTime = Lib.getTimer();
		
		super ();
		
		ct = new ColorTransform();
		
		waitUntil = Lib.getTimer()/1000 + wait;
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function onEnterFrame(e:Event):Void
	{
		var time = Lib.getTimer();
		elapsed = (time - lastTime) / 1000;
		lastTime = time;
		
		if (time/1000 > waitUntil)
		{
			waitUntil = Math.POSITIVE_INFINITY;
			stressTest();
		}
	}
	
	public function stressTest():Void
	{
		trace("[" + iterations + "] phase " + phase);
		
		if (bitmap == null)
		{
			bitmap = new Bitmap(Assets.getBitmapData("assets/test.png"));
			stage.addChild(bitmap);
		}
		
		switch(phase)
		{
			case 0:
				bitmap.bitmapData = Assets.getBitmapData("assets/test.png").clone();
			case 1, 2, 3:
				var bmp = bitmap.bitmapData.clone();
				ct.redMultiplier = Math.random();
				ct.greenMultiplier = Math.random();
				ct.blueMultiplier = Math.random();
				bmp.colorTransform(bitmap.bitmapData.rect, ct);
				bitmap.bitmapData = bmp;
				if (phase == 3)
				{
					phase = -1;
				}
		}
		
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		
		waitUntil = Lib.getTimer() / 1000 + wait;
		phase++;
		iterations++;
	}
}