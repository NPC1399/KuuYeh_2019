// https://blockly-demo.appspot.com/static/demos/blockfactory/index.html#frfjnd
Blockly.Blocks['gobtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/up-btn.png", 30, 30, "*"))
        .appendField("Forward ")
        .appendField(new Blockly.FieldNumber(0, 0, 50), "x")
        .appendField(" cm");
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picgo.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(146);
    this.setTooltip('');

  }
};

Blockly.Python['gobtn'] = function(block) {
  var number_x = block.getFieldValue('x');
  var code = 'robot.mobile.forward('+number_x+')\n';
  return code;
};

Blockly.Blocks['forward_always'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/up-btn.png", 30, 30, "*"))
        .appendField("Forward");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(146);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['forward_always'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'robot.mobile.forward_always()\n';
  return code;
};

Blockly.Blocks['gobackbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/down-btn.png", 30, 30, "*"))
        .appendField("Backward ")
        .appendField(new Blockly.FieldNumber(0, 0, 50), "x")
        .appendField(" cm");
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picgoback.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
  }
};


Blockly.Python['gobackbtn'] = function(block) {
  var number_x = block.getFieldValue('x');
  var code = 'robot.mobile.backward('+number_x+')\n';
  return code;
};


Blockly.Blocks['backward_always'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/down-btn.png", 30, 30, "*"))
        .appendField("Backward");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['backward_always'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'robot.mobile.backward_always()\n';
  return code;
};


Blockly.Blocks['turnleftbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/left-btn.png", 30, 30, "*"))
        .appendField("Turn Left ")
        .appendField(new Blockly.FieldAngle(90), "x")
        .appendField(" °");
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picleft.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(300);
    this.setTooltip('');
  }
};


Blockly.Python['turnleftbtn'] = function(block) {
  var angle_x = block.getFieldValue('x');
  var code = 'robot.mobile.turnleft('+angle_x+')\n';
  return code;
};

Blockly.Blocks['turnleft_always'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/left-btn.png", 30, 30, "*"))
        .appendField("Turn Left");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(300);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['turnleft_always'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'robot.mobile.turnleft_always()\n';
  return code;
};


Blockly.Blocks['turnrightbtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/right-btn.png", 30, 30, "*"))
        .appendField("Turn Right")
        .appendField(new Blockly.FieldAngle(90), "x")
        .appendField(" °");
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picright.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(180);
    this.setTooltip('');
  }
};

Blockly.Python['turnrightbtn'] = function(block) {
  var angle_x = block.getFieldValue('x');
  var code = 'robot.mobile.turnright('+angle_x+')\n';
  return code;
};

Blockly.Blocks['turnright_always'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/right-btn.png", 30, 30, "*"))
        .appendField("Turn Right");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(180);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['turnright_always'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'robot.mobile.turnright_always()\n';
  return code;
};


Blockly.Blocks['delaybtn'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/delay-btn.png", 30, 30, "*"))
        .appendField("Delay ")
        .appendField(new Blockly.FieldNumber(500, 0, 1000), "x")
        .appendField(" Millisecond");
        //.appendField(new Blockly.FieldImage("http://micropyblocky.azurewebsites.net/img/picclock.png", 30, 30, "*"));
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
  }
};

Blockly.Python['delaybtn'] = function(block) {
  var number_x = block.getFieldValue('x');
  var code = 'pyb.delay('+number_x+')\n';
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
    this.setColour(240);
    this.setTooltip('');
  }
};

Blockly.Python['stopbtn'] = function(block) {
  var code = 'robot.mobile.stop()\n';
  return code;
};



Blockly.Blocks['sendulrasonic'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/ultra-btn.png", 30, 30, "*"))
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField("Ultrasonic");
    this.setInputsInline(true);
    this.setOutput(true, null);
    this.setColour(195);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};


Blockly.Python['sendulrasonic'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = '';
  code = 'robot.readUltra()';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Python.ORDER_NONE];
};





Blockly.Blocks['buzzer_block'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/buzzer-btn.png", 30, 30, "*"))
        .appendField("Buzzer :")
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/buzzer-on-btn.png","width":30,"height":30,"alt":"ON"},"on"], [{"src":"assets/img/buzzer-off-btn.png","width":30,"height":30,"alt":"OFF"},"off"]]), "buzzer-drop");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['buzzer_block'] = function(block) {
  var dropdown_buzzer_drop = block.getFieldValue('buzzer-drop');
  // TODO: Assemble Python into code variable.
  var code = '';
  if(dropdown_buzzer_drop == "on")
    code = 'robot.sendBuzzer(1)\n';
  else if (dropdown_buzzer_drop == "off")
    code = 'robot.sendBuzzer(0)\n';
  // TODO: Change ORDER_NONE to the correct strength.
  return code;
};


Blockly.Blocks['red_led'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Red LED :")
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/red-btn.png","width":30,"height":30,"alt":"ON"},"on"], [{"src":"assets/img/led-off.png","width":30,"height":30,"alt":"OFF"},"off"]]), "red_drop");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(0);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

  Blockly.Python['red_led'] = function(block) {
  var dropdown_red = block.getFieldValue('red_drop');
  var code = '';
  // TODO: Assemble Python into code variable.
  if(dropdown_red == "on")
    code = 'robot.ledRed(1)\n';
  else if (dropdown_red == "off")
    code = 'robot.ledRed(0)\n';
  return code;
};


Blockly.Blocks['green_led'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Green LED :")
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/green-btn.png","width":30,"height":30,"alt":"ON"},"on"], [{"src":"assets/img/led-off.png","width":30,"height":30,"alt":"OFF"},"off"]]), "green_drop");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(120);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['green_led'] = function(block) {
  var dropdown_green_drop = block.getFieldValue('green_drop');
   var code = '';
  // TODO: Assemble Python into code variable.
  if(dropdown_green_drop == "on")
    code = 'robot.ledGreen(1)\n';
  else if (dropdown_green_drop == "off")
    code = 'robot.ledGreen(0)\n';
  return code;
};

Blockly.Blocks['send_rfid_a'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/rfid-btn.png", 30, 30, "*"))
        .appendField("RFID Reader (Auto)");
    this.setOutput(true, null);
    this.setColour(120);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['send_rfid_a'] = function(block) {
  var code = '';
  code = 'robot.readRFIDa()';
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['send_rfid_m'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/rfid-btn.png", 30, 30, "*"))
        .appendField("RFID Reader (Manual)");
    this.setOutput(true, null);
    this.setColour(200);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['send_rfid_m'] = function(block) {
  var code = '';
  code = 'robot.readRFIDm()';
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['rfid_list'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/tag-play.png","width":30,"height":30,"alt":"PLAY"},"play"], [{"src":"assets/img/tag-record.png","width":30,"height":30,"alt":"RECORD"},"record"], [{"src":"assets/img/tag-up.png","width":30,"height":30,"alt":"UP"},"up"], [{"src":"assets/img/tag-down.png","width":30,"height":30,"alt":"DOWN"},"down"], [{"src":"assets/img/tag-left.png","width":30,"height":30,"alt":"LEFT"},"left"], [{"src":"assets/img/tag-right.png","width":30,"height":30,"alt":"RIGHT"},"right"]]), "rfid_slot");
    this.setOutput(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['rfid_list'] = function(block) {
  var dropdown_rfid_slot_list = block.getFieldValue('rfid_slot');
  var code = '';
  if(dropdown_rfid_slot_list == "play")
    code = "'play'";
  else if (dropdown_rfid_slot_list == "record")
    code = "'record'";
  else if (dropdown_rfid_slot_list == "up")
    code = "'forward'";
  else if (dropdown_rfid_slot_list == "down")
    code = "'backward'";
  else if (dropdown_rfid_slot_list == "left")
    code = "'left'";
  else if (dropdown_rfid_slot_list == "right")
    code = "'right'";
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['send_color'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/color-btn.png", 30, 30, "*"))
        .appendField("Color Sensor")
        .appendField(new Blockly.FieldDropdown([["Slot1","1"], ["Slot2","2"], ["Slot3","3"], ["Slot4","4"], ["Slot5","5"], ["Slot6","6"]]), "color_slot");
    this.setOutput(true, null);
    this.setColour(255);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['send_color'] = function(block) {
  var dropdown_color_slot = block.getFieldValue('color_slot');
  var code = '';
  if(dropdown_color_slot == "1")
    code = 'robot.readColor(1)';
  else if (dropdown_color_slot == "2")
    code = 'robot.readColor(2)';
  else if (dropdown_color_slot == "3")
    code = 'robot.readColor(3)';
  else if (dropdown_color_slot == "4")
    code = 'robot.readColor(4)';
  else if (dropdown_color_slot == "5")
    code = 'robot.readColor(5)';
  else if (dropdown_color_slot == "6")
    code = 'robot.readColor(6)';
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['color_list'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/red-color.png","width":30,"height":30,"alt":"RED"},"red"], [{"src":"assets/img/green-color.png","width":30,"height":30,"alt":"GREEN"},"green"], [{"src":"assets/img/blue-color.png","width":30,"height":30,"alt":"BLUE"},"blue"], [{"src":"assets/img/black-color.png","width":30,"height":30,"alt":"BLACK"},"black"], [{"src":"assets/img/white-color.png","width":30,"height":30,"alt":"WHITE"},"white"], [{"src":"assets/img/cyan-color.png","width":30,"height":30,"alt":"CYAN"},"cyan"], [{"src":"assets/img/yellow-color.png","width":30,"height":30,"alt":"YELLOW"},"yellow"]]), "color_slot");
    this.setOutput(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['color_list'] = function(block) {
  var dropdown_color_slot_list = block.getFieldValue('color_slot');
  var code = '';
  if(dropdown_color_slot_list == "red")
    code = "'red'";
  else if (dropdown_color_slot_list == "green")
    code = "'green'";
  else if (dropdown_color_slot_list == "blue")
    code = "'blue'";
  else if (dropdown_color_slot_list == "black")
    code = "'black'";
  else if (dropdown_color_slot_list == "white")
    code = "'white'";
  else if (dropdown_color_slot_list == "cyan")
    code = "'cyan'";
   else if (dropdown_color_slot_list == "yellow")
    code = "'yellow'";
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['send_remote'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/ir-btn.png", 30, 30, "*"))
        .appendField("IR Remote");
    this.setOutput(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['send_remote'] = function(block) {
  var code = '';
  code = 'robot.readRemote()';
  return [code, Blockly.Python.ORDER_NONE];
};


Blockly.Blocks['ir_list'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/up-remote.png","width":30,"height":30,"alt":"UP"},"up"], 
          [{"src":"assets/img/right-remote.png","width":30,"height":30,"alt":"RIGHT"},"right"], 
          [{"src":"assets/img/ok-remote.png","width":30,"height":30,"alt":"OK"},"ok"], 
          [{"src":"assets/img/left-remote.png","width":30,"height":30,"alt":"LEFT"},"left"], 
          [{"src":"assets/img/down-remote.png","width":30,"height":30,"alt":"DOWN"},"down"], 
          [{"src":"assets/img/1-remote.png","width":30,"height":30,"alt":"ONE"},"1"], 
          [{"src":"assets/img/2-remote.png","width":30,"height":30,"alt":"TWO"},"2"],
          [{"src":"assets/img/3-remote.png","width":30,"height":30,"alt":"THREE"},"3"],
          [{"src":"assets/img/4-remote.png","width":30,"height":30,"alt":"FOUR"},"4"],
          [{"src":"assets/img/5-remote.png","width":30,"height":30,"alt":"FIVE"},"5"],
          [{"src":"assets/img/6-remote.png","width":30,"height":30,"alt":"SIX"},"6"],
          [{"src":"assets/img/7-remote.png","width":30,"height":30,"alt":"SEVEN"},"7"],
          [{"src":"assets/img/8-remote.png","width":30,"height":30,"alt":"EIGHT"},"8"],
          [{"src":"assets/img/9-remote.png","width":30,"height":30,"alt":"NIGHT"},"9"],
          [{"src":"assets/img/star-remote.png","width":30,"height":30,"alt":"STRA"},"*"],
          [{"src":"assets/img/0-remote.png","width":30,"height":30,"alt":"ZERO"},"0"],
          [{"src":"assets/img/hashtag-remote.png","width":30,"height":30,"alt":"HASHTAG"},"#"],
          [{"src":"assets/img/pullup-remote.png","width":30,"height":30,"alt":"PULLUP"},"pullup"]]),"ir_button_slot");

    this.setOutput(true, null);
    this.setColour(120);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['ir_list'] = function(block) {
  var dropdown_ir_slot_list = block.getFieldValue('ir_button_slot');
  var code = '';
  if(dropdown_ir_slot_list == "up")
    code = "'1'";
  else if (dropdown_ir_slot_list == "right")
    code = "'4'";
  else if (dropdown_ir_slot_list == "ok")
    code = "'3'";
  else if (dropdown_ir_slot_list == "left")
    code = "'2'";
  else if (dropdown_ir_slot_list == "down")
    code = "'5'";
  else if (dropdown_ir_slot_list == "1")
    code = "'6'";
  else if (dropdown_ir_slot_list == "2")
    code = "'7'";
  else if (dropdown_ir_slot_list == "3")
    code = "'8'";
  else if (dropdown_ir_slot_list == "4")
    code = "'9'";
  else if (dropdown_ir_slot_list == "5")
    code = "'10'";
  else if (dropdown_ir_slot_list == "6")
    code = "'11'";
  else if (dropdown_ir_slot_list == "7")
    code = "'12'";
  else if (dropdown_ir_slot_list == "8")
    code = "'13'";
  else if (dropdown_ir_slot_list == "9")
    code = "'14'";
  else if (dropdown_ir_slot_list == "*")
    code = "'15'";
  else if (dropdown_ir_slot_list == "0")
    code = "'16'";
  else if (dropdown_ir_slot_list == "#")
    code = "'17'";
  else if (dropdown_ir_slot_list == "pullup")
    code = "'0'";
  return [code, Blockly.Python.ORDER_NONE];
};


Blockly.Blocks['buzzer_wireless_block'] = {
  init: function() {
    this.appendDummyInput()
        .setAlign(Blockly.ALIGN_CENTRE)
        .appendField(new Blockly.FieldImage("assets/img/buzzer-btn.png", 30, 30, "*"))
        .appendField("Wireless Buzzer :")
        .appendField(new Blockly.FieldDropdown([[{"src":"assets/img/buzzer-on-btn.png","width":30,"height":30,"alt":"ON"},"on"], [{"src":"assets/img/buzzer-off-btn.png","width":30,"height":30,"alt":"OFF"},"off"]]), "buzzer_wireless_drop");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['buzzer_wireless_block'] = function(block) {
  var buzzer_wireless_drop = block.getFieldValue('buzzer_wireless_drop');

  var buzzer_wireless_state = "";
  // TODO: Assemble Python into code variable.
  var code = '';


  if(buzzer_wireless_drop == "on")
    buzzer_wireless_drop = "':B1:'";
  else if (buzzer_wireless_drop == "off")
    buzzer_wireless_drop = "':B0:'";
  

  code = 'robot.uart.write('+buzzer_wireless_drop+')\n';
  // TODO: Change ORDER_NONE to the correct strength.
  return code;
};


Blockly.Blocks['netpie'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/netpiePic.png", 204, 52, "*"));
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("WIFI name : ")
        .appendField(new Blockly.FieldTextInput("..."), "wifi");
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("WIFI password : ")
        .appendField(new Blockly.FieldTextInput("..."), "pass");
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("APPID : ")
        .appendField(new Blockly.FieldTextInput("..."), "appid");
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("KEY : ")
        .appendField(new Blockly.FieldTextInput("..."), "key");
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("SECRET : ")
        .appendField(new Blockly.FieldTextInput("..."), "secret");
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("ALIAS : ")
        .appendField(new Blockly.FieldTextInput("..."), "alias");
    this.setInputsInline(false);
    this.setNextStatement(true, null);
    this.setColour(0);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['netpie'] = function(block) {
  var code = '...\n';
  var text_wifi = block.getFieldValue('wifi');
  var text_pass = block.getFieldValue('pass');
  var text_appid = block.getFieldValue('appid');
  var text_key = block.getFieldValue('key');
  var text_secret = block.getFieldValue('secret');
  var text_alias = block.getFieldValue('alias');
  // TODO: Assemble Python into code variable.
  code = 'robot.netpieConnect('+"'"+text_wifi+"'"+","+"'"+text_pass+"'"+","+"'"+text_appid+"'"+","+"'"+text_key+"'"+","+"'"+text_secret+"'"+","+"'"+text_alias+"'"+')\n';
  return code;
};

Blockly.Blocks['netpieconnect'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/netpieConnect.png", 153, 39, "*"));
    this.setOutput(true, null);
    this.setColour(150);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['netpieconnect'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = '(robot.Netpie_State == 2)';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Python.ORDER_NONE];
};

Blockly.Blocks['netpieout'] = {
  init: function() {
    this.appendValueInput("ValueToPie")
        .setCheck(null)
        .appendField(new Blockly.FieldImage("assets/img/point.png", 15, 15, "*"))
        .appendField("Send");
    this.appendDummyInput()
        .appendField("to : NETPIE")
        .appendField(new Blockly.FieldDropdown([["OUT1","out1"], ["OUT2","out2"], ["OUT3","out3"]]), "NAMEOUT");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(210);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};


Blockly.Python['netpieout'] = function(block) {
  var value_valuetopie = Blockly.Python.valueToCode(block, 'ValueToPie', Blockly.Python.ORDER_ATOMIC);
  var dropdown_out = block.getFieldValue('NAMEOUT');
  var code = '...\n';
  var outTopie;
  if(dropdown_out == "out1")
    outTopie = 1;
  else if (dropdown_out == "out2")
    outTopie = 2;
  else if (dropdown_out == "out3")
    outTopie = 3;
  code = 'robot.sendNetpie('+value_valuetopie+","+outTopie+')\n'; 
  return code;
};


Blockly.Blocks['nfc_mode'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldImage("assets/img/nfc-mode.png", 219, 136, "*"));
    this.setColour(195);
    this.setTooltip('');
    this.setHelpUrl('');
  }
};

Blockly.Python['nfc_mode'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'robot.nfcMode()\n';
  return code;
};


Blockly.Blocks['led_red_on'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("LED RED ON");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(0);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['led_red_on'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'x.on()\n';
  return code;
};

Blockly.Blocks['led_red_off'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("LED RED OFF");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(15);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['led_red_off'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'x.off()\n';
  return code;
};

Blockly.Blocks['led_set'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("LED RED SET");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(200);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['led_set'] = function(block) {
  // TODO: Assemble Python into code variable.
  var code = 'x = pyb.LED(4)\n';
  return code;
};

Blockly.Blocks['equal'] = {
  init: function() {
    this.appendValueInput("Value1")
        .setCheck(null)
        .setAlign(Blockly.ALIGN_CENTRE);
    this.appendDummyInput()
        .appendField("=");
    this.appendValueInput("Value2")
        .setCheck(null)
        .setAlign(Blockly.ALIGN_CENTRE);
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(15);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Python['equal'] = function(block) {
  var value_value1 = Blockly.Python.valueToCode(block, 'Value1', Blockly.Variables.NAME_TYPE);
  var value_value2 = Blockly.Python.valueToCode(block, 'Value2', Blockly.Python.ORDER_NONE) || '0';
  // TODO: Assemble Python into code variable.
  var code = value_value1 + ' = ' + value_value2 + '\n';
  // TODO: Change ORDER_NONE to the correct strength.
  return code;
};


Blockly.Blocks['variable'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Variable Name: ")
        .appendField(new Blockly.FieldTextInput("val"), "NAME");
    this.setOutput(true, null);
    this.setColour(210);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};


Blockly.Python['variable'] = function(block) {
  var text_name = block.getFieldValue('NAME');
  // TODO: Assemble Python into code variable.
  var code = text_name;
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Variables.NAME_TYPE];
};


