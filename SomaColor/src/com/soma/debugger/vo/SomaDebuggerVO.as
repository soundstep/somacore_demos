package com.soma.debugger.vo {
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPluginVO;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />* <b>Class version:</b> 1.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b> 
	 * <br />
	 * <b>Date:</b> Sep 24, 2009<br />
	 * <b>Usage:</b>
	 * @example
	 * <listing version="3.0"></listing>
	 */
	
	public class SomaDebuggerVO implements ISomaPluginVO {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		public var instance:ISoma;
		public var debuggerName:String;
		public var commands:Array;
		public var enableLog:Boolean;
		public var enableTrace:Boolean;
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerVO(instance:ISoma, debuggerName:String = null, commands:Array = null, enableLog:Boolean = true, enableTrace:Boolean = true) {
			if (instance == null) throw new Error("Error in " + this + " ISoma instance is null.");
			this.instance = instance;
			this.debuggerName = (debuggerName == null || debuggerName == "") ? "Soma::SomaDebugger" : debuggerName;
			this.commands = (commands == null) ? [] : commands;
			this.enableLog = enableLog;
			this.enableTrace = enableTrace;
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		
		
	}
}