package ;
import browser.utils.ByteArray;
import nme.display.BitmapData;
import nme.display.BitmapInt32;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Memory;

/**
 * ...
 * @author Lars Doucet
 */
class Test extends BitmapData
{

	public function new(width:Int, height:Int, transparent:Bool = true, fillColor:BitmapInt32 = 0xFFFFFFFF)
	{
		super(width, height, transparent, fillColor);
	}
	
	/*
	public function threshold(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:Int, color:Int, mask:Int = 0xFFFFFFFF, copySource:Bool = false):Int {
	   var width:Int = width;
	   var height:Int = height;
	   var hits:Int = 0;
	   
	   for (xx in 0...width) {
		   for (yy in 0...height) {
			   var pixelValue:BitmapInt32 = getPixel32(xx, yy);
			   var boolTest:Bool = false;
			   switch(operation) {
				   case "<": boolTest = pixelValue & mask < threshold & mask;
				   case ">": boolTest = pixelValue & mask > threshold & mask;
				   case "<=": boolTest = pixelValue & mask <= threshold & mask;
				   case ">=": boolTest = pixelValue & mask >= threshold & mask;
				   case "==": boolTest = pixelValue & mask == threshold & mask;
				   case "!=": boolTest = pixelValue & mask != threshold & mask;
			   }
			   if(boolTest){
				   //setPixel32(xx, yy, color);
				   hits++;
			   }else if (copySource) {
   				   setPixel32(xx, yy, sourceBitmapData.getPixel32(xx, yy));				   
				   hits++;
			   }
		   }
	   }
	   return hits;
   }
   //*/
   
   //*
   public function threshold(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:Int, color:Int, mask:Int = 0xFFFFFFFF, copySource:Bool = false):Int {
	   var width:Int = width;
	   var height:Int = height;
	   var hits:Int = 0;
	   
	   //the virtual memory space, for texture data(resX&resY)
	   var vRam:ByteArray = new ByteArray();
	   //32bits integer = 4 bytes
	   #if cpp
			vRam.setLength((width * height) * 4);
	   #else
			vRam.length = (width * height) * 4;
	   #end
	   
	   //write texture into RAM
	   var data:ByteArray = getPixels(rect);
	   vRam.position = 0;
	   vRam.writeBytes(data, 0, data.length);
	   #if flash
			data.clear();
	   #end
	   
	   //Select the memory space (just once)
	   Memory.select(vRam);
	   	   
	   for (xx in 0...width) {
		   for (yy in 0...height) {
			   var pixelValue:BitmapInt32 = Memory.getI32(((width * yy) + xx)*4);
			   var test:Bool = false;
			   switch(operation) {
				   case "<":test = pixelValue & mask < threshold & mask;
				   case ">": test = pixelValue & mask > threshold & mask;
				   case "<=": test = pixelValue & mask <= threshold & mask;
				   case ">=": test = pixelValue & mask >= threshold & mask;
				   case "==": test = pixelValue & mask == threshold & mask;
				   case "!=": test = pixelValue & mask != threshold & mask;
			   }
			   if (test) {				   
				   Memory.setI32( ((width * yy) + xx) * 4 , color);
				   hits++;
			   }else if (copySource) {
				   
   				   setPixel32(xx, yy, sourceBitmapData.getPixel32(xx, yy));				   
				   hits++;
			   }
		   }
	   }
	   
	   vRam.position = 0;
	   setPixels(rect, vRam);
	   return hits;
   }
   //*/
}