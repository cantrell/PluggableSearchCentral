package com.adobe.searchcentral
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.security.IURIDereferencer;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	public class URIDereferencer implements IURIDereferencer
	{
		private var sig:XML;
		private const sigNS:Namespace = new Namespace("http://www.w3.org/2000/09/xmldsig#");
		
		public function URIDereferencer(sig:XML)
		{
			this.sig = sig;
		}
		
		public function dereference(uri:String):IDataInput
		{
			if (uri == "#PackageContents")
			{
				var ref:XML = this.sig..sigNS::Manifest.(@Id == "PackageContents")[0];
				var refBytes:ByteArray = new ByteArray();
				refBytes.writeUTFBytes(ref.toXMLString());
				refBytes.position = 0;
				return refBytes;
			}
			return null;
		}
	}
}