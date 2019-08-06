Blockly.Blocks['setup_matrix_led'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Setup Matrix-LED");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};
Blockly.Python['setup_matrix_led'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'import pyb\nimport Display\ndisp = Display.Display()\n';
  return code;
};


////////////////////////////////////////////


Blockly.Blocks['turn_on_off_light'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Turn On/Off Light")
        .appendField(new Blockly.FieldDropdown([["On","open"], ["Off","close"]]), "on_off");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};
Blockly.Python['turn_on_off_light'] = function(block) {
  var dropdown_on_off = block.getFieldValue('on_off');
  // TODO: Assemble Python into code variable.
  var code = 'disp.'+dropdown_on_off+'()\n';
  return code;
};

/////////////////////////////////////////////