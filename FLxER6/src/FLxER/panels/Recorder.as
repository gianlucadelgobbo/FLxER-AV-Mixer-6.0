﻿package FLxER.panels {	import flash.display.Sprite;	import flash.events.*;	import flash.utils.*;	import flash.net.*;	import flash.xml.XMLDocument;    import flash.net.FileReference;	import FLxER.main.Txt;	import FLxER.comp.CheckBoxBase;	import FLxER.comp.ButtonTxt;		public class Recorder extends Sprite {		private var myLL:XMLDocument;		private var P:Txt,L:Txt,X:Txt;		//		private var myRecOnOff:CheckBoxBase;		private var myLibSel:ButtonTxt;		private var myLoop:CheckBoxBase;		private var myStop:ButtonTxt;		///		private var recStatus:Boolean;		private var MyFile:FileReference;		public var loopStatus:Boolean;		public var myLiveset:XMLDocument;		public function Recorder(xx:int):void {			x = xx			//R				 = new Txt(-3, 0, 0, 15, "RECORDER", Preferences.th, null);			//this.addChild(R);			myRecOnOff		 = new CheckBoxBase(0, 7, 99, 15, "START RECORDING", recOnOff, null, false);			this.addChild(myRecOnOff);			//			//P				 = new Txt(101, 0, 38, 15, "PLAYER", Preferences.th, null);			//this.addChild(P);			myLibSel		 = new ButtonTxt(104, 7, 33, 15, "OPEN", loadLlivesetSO, null, null);			this.addChild(myLibSel);			myLoop			 = new CheckBoxBase(142, 7, 32, 15, "LOOP", loop, null, false);			this.addChild(myLoop);			myStop			 = new ButtonTxt(179, 7, 32, 15, "STOP", stopLiveset, null, null);			this.addChild(myStop);			myStop.visible = myLoop.visible = false;			recStatus = false;			loopStatus = false;		}		private function recOnOff(p:Boolean):void {			Preferences.pref.recStatus = p;			if (p) {				myLiveset		 = new XMLDocument();				myLiveset.ignoreWhite = true;				myLiveset.parseXML("<liveset></liveset>");				var today_date:Date		 = new Date();				myLiveset.childNodes[0].attributes.date = today_date.getDate()+"/"+(today_date.getMonth()+1)+"/"+today_date.getFullYear();				for (var a:int=0; a<Preferences.pref.nCh; a++) {					Preferences.interfaceTrgt.chCnt["ch_"+a].live(true);				}				Preferences.lastTime = getTimer();				myLoop.visible = false;				myLibSel.visible = false;				//P.visible = false;				myStop.visible = false;				myRecOnOff.lab.text = "STOP RECORDING"			} else {				MyFile = new FileReference();				MyFile.save(myLiveset, "liveset.xml");				myLibSel.visible = true;				//P.visible = true;				myRecOnOff.lab.text = "START RECORDING"			}		}		private function stopLiveset(p:String):void {			Preferences.monitorTrgt.stop_liveset();		}		private function selectHandler(event:Event):void {            var file:FileReference = FileReference(event.target);            trace("selectHandler: name=" + file.name);            MyFile.load();        }		public function loadLlivesetSO(val):void {			MyFile = new FileReference();			MyFile.addEventListener(Event.SELECT, selectHandler);            MyFile.addEventListener(Event.COMPLETE, loadLliveset);            MyFile.browse();        }		private function loadLliveset(e:Event):void {			trace("loadLliveset")			myLoop.visible = true;			myStop.visible = true;			myLiveset = new XMLDocument();			myLiveset.ignoreWhite = true;			trace(MyFile.data)			trace(e)			myLiveset.parseXML(MyFile.data.toString());			liveok();		}		private function loop(p:Boolean):void {			loopStatus = p;		}		private function liveok():void {			Preferences.monitorTrgt.livesetIndex = 0;			Preferences.monitorTrgt.play_liveset();		}	}}