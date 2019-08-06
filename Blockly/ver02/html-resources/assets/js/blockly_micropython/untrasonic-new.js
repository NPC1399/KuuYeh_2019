// https://blockly-demo.appspot.com/static/demos/blockfactory/index.html#frfjnd
Blockly.Blocks['gobtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/up-btn.png", 30, 30, "*"));
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("Forward")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picgo.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(146);
    this.setTooltip('');

  }
};

Blockly.Python['gobtn'] = function(block) {
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var code = 'robot.forward('+value_x+')\n';
  return code;
};

Blockly.Blocks['gobackbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/down-btn.png", 30, 30, "*"));
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("Backward")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picgoback.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(65);
    this.setTooltip('');
  }
};

Blockly.Python['gobackbtn'] = function(block) {
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var code = 'robot.backward('+value_x+')\n';
  return code;
};

Blockly.Blocks['turnleftbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/left-btn.png", 30, 30, "*"));
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("Turn Left")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picleft.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(20);
    this.setTooltip('');
  }
};

Blockly.Python['turnleftbtn'] = function(block) {
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var code = 'robot.turnleft('+value_x+')\n';
  return code;
};


Blockly.Blocks['turnrightbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/right-btn.png", 30, 30, "*"));
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("Turn Right")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picright.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(120);
    this.setTooltip('');
  }
};

Blockly.Python['turnrightbtn'] = function(block) {
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var code = 'robot.turnright('+value_x+')\n';
  return code;
};


Blockly.Blocks['delaybtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/delay-btn.png", 30, 30, "*"));
    this.appendValueInput("x")
        .setCheck("Number")
        .appendField("Delay")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picclock.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(290);
    this.setTooltip('');
  }
};

Blockly.Python['delaybtn'] = function(block) {
  var value_x = Blockly.Python.valueToCode(block, 'x', Blockly.Python.ORDER_ATOMIC);
  var code = 'pyb.delay('+value_x+')\n';
  return code;
};


Blockly.Blocks['stopbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/stop-btn.png", 30, 30, "*"));
    this.appendDummyInput()
        .appendField("Stop")
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picstop.png", 30, 30, "*"));
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
  }
};

Blockly.Python['stopbtn'] = function(block) {
  var code = 'robot.stop()\n';
  return code;
};