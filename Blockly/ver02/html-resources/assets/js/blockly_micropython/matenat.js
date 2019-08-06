Blockly.Blocks['say_word'] = {
  init: function() {
    this.appendValueInput("Valuedata")
        .setCheck("String")
        .appendField("Say Word :");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(180);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['say_word'] = function(block) {
  var value_valuedata = Blockly.Python.valueToCode(block, 'Valuedata', Blockly.Python.ORDER_ATOMIC);
  // TODO: Assemble Python into code variable.
  var code = 'robot.say_word('+value_valuedata+')\n';
  return code;
};