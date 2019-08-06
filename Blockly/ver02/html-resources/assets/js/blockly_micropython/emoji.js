// https://blockly-demo.appspot.com/static/demos/blockfactory/index.html#frfjnd

Blockly.Blocks['led_smile'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Smile")
        .appendField(new Blockly.FieldImage("assets/img/smile.png", 219, 136, "*"));
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(300);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['led_smile'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'print("Smile")\n';
  return code;
};