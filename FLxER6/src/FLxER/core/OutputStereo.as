﻿package FLxER.core {	import flash.display.Loader;	import flash.display.Sprite;	import flash.events.Event;	import flash.net.LocalConnection;	import flash.utils.clearInterval;	import flash.utils.getTimer;	import flash.utils.setInterval;	import flash.xml.XMLDocument;		import FLxER.core.Player;	import FLxER.main.Rett;	public class OutputStereo extends Sprite {		private var nCh:uint;		public var fondo:Rett;		public var levels:Object;		public var levels2:Object;		public var w:uint;		public var h:uint;		//		private var myAction:Array;		public var mon1:Sprite; 		public var mon2:Sprite; 		private var myMask1:Rett;		private var myMask2:Rett;		public function OutputStereo(xx:Number, yy:Number, ww:uint, hh:uint, n:uint):void {			Preferences.nLoadErr = new Object();			Preferences.currentMedia = new Object();			x = xx;			y = yy;			w = ww;			h = hh;			nCh = n;			fondo = new Rett(0,0,w*2,h,Preferences.pref.myCol.monCol,-1,1);			this.addChild(fondo);			mon1 = new Sprite();			mon2 = new Sprite();			this.addChild(mon2);			this.addChild(mon1);			mon2.x = w;			myMask1 = new Rett(0,0,w,h,Preferences.pref.myCol.monCol,-1,1);			myMask2 = new Rett(w,0,w,h,Preferences.pref.myCol.monCol,-1,1);			this.addChild(myMask1);			this.addChild(myMask2);			this.mon1.mask = myMask1;			this.mon2.mask = myMask2;			/**/			levels = new Object();			levels2 = new Object();			for (var a:int=0; a<Preferences.pref.nCh; a++) {				levels["ch_"+a] = new Player(a,w,h,this,"left",false);				levels2["ch_"+a] = new Player(a,w,h,this,"right",false);				this.mon1.addChild(levels["ch_"+a]);				this.mon2.addChild(levels2["ch_"+a]);			}		}		public function initHandlerSWF(e:Loader,ch:uint):void {		}		public function initHandlerFLV(event:Event,ch:uint):void {		}		public function initHandlerMP3(ch:uint):void {		}		public function initHandlerJPG(e:Loader,ch:uint):void {		}		public function errorHandlerCNT(event:Event,ch:uint):void {		}		public function errorHandlerSWF(event:Event,ch:uint):void {		}		public function errorHandlerFLV(event:Event,ch:uint):void {		}		public function errorHandlerMP3(event:Event,ch:uint):void {		}		public function errorHandlerJPG(event:Event,ch:uint):void {		}		public function errorHandlerWipes(event:Event, ch:uint):void {		}		//		public function resizer():void {			myMask1.width = myMask2.width = mon2.x = myMask2.x = w = Preferences.monObj.monWidth;			myMask1.height = myMask2.height = fondo.height = h = Preferences.monObj.monHeight;			fondo.width = w*2;			for (var a:int=0; a<Preferences.pref.nCh; a++) {				//levels["ch_"+a].resizer(Preferences.pref.w, Preferences.pref.h);				levels["ch_"+a].resizer();				levels2["ch_"+a].resizer();			}		}		public function mbuto1(azione:String):void {			if (Preferences.myPreviewActive) {				myAction = azione.split(",");				levels["ch_"+myAction[2]][myAction[1]](myAction);				Preferences.lastTime = getTimer();			}		}		public function mbuto2(azione:String):void {			if (Preferences.myPreviewActive) {				myAction = azione.split(",");				levels2["ch_"+myAction[2]][myAction[1]](myAction);				Preferences.lastTime = getTimer();			}		}		public function mbuto(azione:String):void {			trace("MMmbutoStereo"+azione);			trace("MMmbutoStereo"+Preferences.myPreviewActive);			myAction = azione.split(",");			levels["ch_"+myAction[2]][myAction[1]](myAction);			levels2["ch_"+myAction[2]][myAction[1]](myAction);		}	}}