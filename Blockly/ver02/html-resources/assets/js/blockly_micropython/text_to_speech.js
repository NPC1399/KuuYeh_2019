Blockly.Blocks['talk'] = {
  init: function() {
    this.appendValueInput("tex_vioce")
        .setCheck("String")
        .appendField("Talk: ")
        .appendField(new Blockly.FieldImage("assets/img/talk.png", 50, 50, "*"));
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(195);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['talk'] = function(block) {
  var value_tex_vioce = Blockly.Python.valueToCode(block, 'tex_vioce', Blockly.Python.ORDER_ATOMIC);
  // TODO: Assemble Python into code variable.
  var code = 'mic.S1V30120_speech("'+value_tex_vioce+'",0)\n';
  return code;
};

Blockly.Blocks['settalk'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Set Text to Speech");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(195);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['settalk'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'import S1V30120\nfrom pyb import SPI\nspi = SPI(3, SPI.MASTER, baudrate=750000, polarity=1, phase=1, bits=8, firstbit=SPI.MSB)\nmic = S1V30120.S1V30120(spi)\nmic.enableS1V()\n';
  return code;
};