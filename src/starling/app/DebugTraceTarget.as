package starling.app
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DebugTraceTarget
	{
		private var debugTextField:TextField;
		public function DebugTraceTarget(stage: Stage, debug: Boolean = true)
		{
			if (!debug) {
				return;
			}
			debugTextField = new TextField();
			debugTextField.defaultTextFormat = new TextFormat("Arial", 20, 0xFF8800);
			debugTextField.width = stage.stageWidth;
			debugTextField.height = stage.stageHeight - 300;
			stage.addChild(debugTextField);
			
			Logger.addTraceTarget(function(message: String): void {
				debugTextField.appendText(message + "\n");
				debugTextField.scrollV = debugTextField.numLines + 1;
			});
		}
	}
}