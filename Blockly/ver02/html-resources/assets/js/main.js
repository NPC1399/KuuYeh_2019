//////////////////////////////////////////////////////
/////////////// GLOBAL VARIABLES /////////////////////

var mode = 'block';
var latestCode = "";
var code = "";
var codeChanged = false;
var output = document.querySelector('output');
var textarea = '#thecode';

//////////////////////////////////////////////////////
/////////////// COMMON FUNCTIONS /////////////////////

// set default editor
if(mode == 'block')
	$('#code-editor').css('z-index', -1);
else
	$('#blocklyDiv').css('z-index', -1);

function errorHandler(e) {
	console.error(e);
}

function codeChanges(isChange)
{
	if(isChange){
		codeChanged = true;
	} else {
		codeChanged = false;
	}
}

function changeMode(mode){
	if(mode == 'block'){
		$('#blocklyDiv').css('z-index', 1);
		$('#code-editor').css('z-index', -1);
	} else {
		$('#blocklyDiv').css('z-index', -1);
		$('#code-editor').css('z-index', 1);
	}
	console.log(mode);
	window.mode = mode;
}

$(window).resize(function(){
	// set separator first position
	$('#separator-bar').css('left', (parseInt($('.code-content').width()) - 50) + 'px');
	$('.output-panel').width($('.wrapper').width() - parseInt($('.code-content').width()));

    // Position blocklyDiv over code-content
    $('#blocklyDiv').width($('.code-content').width() - 50);

    // prevent resize over separator
    if($(window).width() < $('.code-content').width())
		window.resizeTo($('.code-content').width() + 10, $(window).height());
	console.log("Resize Windows");  
})

$(function(){

	/*
	// 	RESIZE COLUMNS
	var $separator = $('#separator-bar').draggabilly({
		axis: 'x',
		containment: '.wrapper'
	})
	var draggie = $separator.data('draggabilly');
	
	$separator.on('dragStart', function(){
		$(this).css({'opacity':0.3});
	})
	$separator.on('dragEnd', function() {
		$(this).css({'opacity':1});
		if(draggie.position.x > 135)
			$('.code-content').width(draggie.position.x + 50);
		else
			$('.code-content').width(185);
		$('.output-panel').width($('.wrapper').width() - draggie.position.x - 50);
	    $('#blocklyDiv').width($('.code-content').width() - 50);
	    // hack resize effect to normalize blockly width
		window.resizeTo($(window).width(), $(window).height()-1);
	})
	*/
	
	$('.bar').show();

	// when PYTHON CODE BUTTON clicked
	$(document).off('click', '.btn-codemode').on('click', '.btn-codemode', function(){
		changeMode('block');
		$(this).addClass('btn-blockmode').removeClass('btn-codemode')
		.attr('title', 'switch to python mode').html('<span><img src="assets/iconscollection/icon32/construction1.png"></img></span>');
	});

	// when BLOCKLY CODE BUTTON clicked
	$(document).off('click', '.btn-blockmode').on('click', '.btn-blockmode', function(){
		changeMode('code');
		$(this).addClass('btn-codemode').removeClass('btn-blockmode')
		.attr('title', 'switch to blockly mode').html('<span><img src="assets/iconscollection/icon32/py1.png"></img></span>');
	});

	// when SHOWCODE BUTTON clicked
	$(document).off('click', '.btn-showcode').on('click', '.btn-showcode', function(){
		cefCustomObject.showDevTools();
	});

	// Upload Code
	$(document).off('click', '.btn-save').on('click', '.btn-save', function(){
		UploadCode(false);
	});

	// INTERRUPT BOTTON
	$(document).off('click', '.btn-interrupt').on('click', '.btn-interrupt', function(){
		cefCustomObject.btn_interrupt();
	});

	// CLEAR TERMINAL
	$(document).off('click', '.btn-clearterminal').on('click', '.btn-clearterminal', function(){
		cefCustomObject.btn_clearterminal();
	});

	// when STOP BUTTON clicked
	$(document).off('click', '.btn-stop').on('click', '.btn-stop', function(){
		cefCustomObject.btn_stop();
		$('.btn-stop').addClass('btn-run').removeClass('btn-stop')
		.attr('title', 'Stop program').html('<span><img src="assets/iconscollection/icon32/arrows-1.png"></img></span>');
	});

	// when RUN BUTTON clicked
	$(document).off('click', '.btn-run').on('click', '.btn-run', function(){
		cefCustomObject.btn_run();
		$('.btn-run').addClass('btn-stop').removeClass('btn-run')
		.attr('title', 'Stop program').html('<span><img src="assets/iconscollection/icon32/stop1.png"></img></span>');
	});
});

//////////////////////////////////////////////////////////////
///////////////////////// CODEMIRROR /////////////////////////
//////////////////////////////////////////////////////////////
var editor = CodeMirror.fromTextArea(document.getElementById('thecode'), {
	lineNumbers: true,
	styleActiveLine: true,
	matchBrackets: true,
	lineWrapping: true,
	showTrailingSpace: true,
	mode: "python",
	theme: "3024-day"

});

editor.on("change", function(cm, changeObj) {
	codeChanges(true);
});

////////////////////////////////////////////////////////////// 
//////////////////////////////////////////////////////////////

function WindowExitCall(){
	var data = cefsave_blocks(); 
	try 
	{
		cefCustomObject.closeapp(data);
	} 
	catch (e) 
	{
		alert(e);
	}
}

function resize_windows(){
	// set separator first position
	$('#separator-bar').css('left', (parseInt($('.code-content').width()) - 50) + 'px');
	$('.output-panel').width($('.wrapper').width() - parseInt($('.code-content').width()));

    // Position blocklyDiv over code-content
    $('#blocklyDiv').width($('.code-content').width() - 50);

    // prevent resize over separator
    if($(window).width() < $('.code-content').width())
		window.resizeTo($('.code-content').width() + 10, $(window).height());
	console.log("function resize windows");
}
resize_windows(); 

document.getElementById('btnclose').onclick = function() {
	console.log("Close Window");  
	var data = cefsave_blocks(); 
	try 
	{
		cefCustomObject.exitapp(data);
	} 
	catch (e) 
	{
		alert(e);
	}
};

document.getElementById('fakenew').onclick = function() {
	console.log("Close Window");  
	var data = cefsave_blocks(); 
	try 
	{
		cefCustomObject.btn_newProject(data);
	} 
	catch (e) 
	{
		alert(e);
	}
};

function UploadCode(savepython) {
	console.log("Upload Code");  
	var pyfile = "";
	var data = "";

	if(mode != 'block'){
		pyfile = editor.getValue();
	} else {
		Blockly.Python.INFINITE_LOOP_TRAP = null;
       	pyfile = Blockly.Python.workspaceToCode(); 
	}

	try {
		data += ("import pyb\n");
		data += ("from pyb import Timer\n");
		data += (pyfile);
		cefCustomObject.upload_code(data,savepython);
	} catch (e) {
	alert(e);
	}
}

document.getElementById('fakesave').onclick = function() {
	saveblocks();
};

function saveblocks() {
	console.log("Save Block");  
	var data = cefsave_blocks(); 
	try {
		cefCustomObject.save_blockly(data);
	} catch (e) {
	alert(e);
	}
}

document.getElementById('fakesavepy').onclick = function() {
	UploadCode(true);
};

var workspace = Blockly.inject(document.getElementById('blocklyDiv'), {
	grid: {
		spacing: 25,
		length: 3,
		colour: '#eee',
		snap: true
	},
	toolbox: document.getElementById('toolbox-beginner')
});

function blocklyUpdate() {
	latestCode = Blockly.Python.workspaceToCode();
	var xml = Blockly.Xml.workspaceToDom(Blockly.getMainWorkspace());
	chrome.storage.local.set({'blockStorage': xml});
}

function myUpdateFunction() {
  var code = Blockly.Python.workspaceToCode(workspace);
  document.getElementById('sortieJS').value = code;
}

Blockly.addChangeListener(myUpdateFunction);
var loadInput = document.getElementById('load');
    loadInput.addEventListener('change', load_blocks, false);
    document.getElementById('fakeload').onclick = function() {
        loadInput.click();
    };
    var query = location.search.substring(1);
    if(query){
        load_query_string(decodeURIComponent(query));
    }

Blockly.addChangeListener(blocklyUpdate);
chrome.storage.local.get('blockStorage', function(result){
	var xml = Blockly.Xml.textToDom(result.blockStorage);
	Blockly.Xml.domToWorkspace(Blockly.getMainWorkspace(), xml);
});