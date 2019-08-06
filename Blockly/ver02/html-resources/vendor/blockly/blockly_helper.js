// This is a reduced version of
// https://github.com/gasolin/BlocklyDuino/blob/master/blockly/apps/blocklyduino/blockly_helper.js
// * `save` is in file_io.js
// * `auto_save_and_restore_blocks` is directly in the page (removed
//   localStorage things).

function save_blocks(filename) {
  var xml = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
  var data = Blockly.Xml.domToText(xml);
  filesave(data, 'text/xml', filename);
  console.log("Save Block");
}

function cefsave_blocks() {
  var xml = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
  var data = Blockly.Xml.domToText(xml);
  return data;
  console.log("CEF Save Block");
}

/**
 * Load blocks from local file.
 */
function load_blocks(event) {
  var files = event.target.files;
  // Only allow uploading one file.
  if (files.length != 1) {
    return;
  }

  // FileReader
  var reader = new FileReader();
  reader.onloadend = function(event) {
    var target = event.target;
    // 2 == FileReader.DONE
    if (target.readyState == 2) {
      try {
        var xml = Blockly.Xml.textToDom(target.result);
      } catch (e) {
        alert('Error parsing XML:\n' + e);
        return;
      }
      var previous_dom = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
      var current_count = Blockly.mainWorkspace.getAllBlocks().length;
      if (current_count && confirm('Replace existing blocks?\n"Cancel" will merge.')) {
        Blockly.mainWorkspace.clear();
      }
      Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, xml);
      var remaining = Blockly.mainWorkspace.remainingCapacity();
      var maxi = Blockly.maxBlocks;
      if (remaining < 0) {
        alert("Trop de blocs (%1 > %2).".replace('%1', maxi - remaining)
                                        .replace('%2', maxi));
        Blockly.mainWorkspace.clear();
        Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, previous_dom);
      }
    }
    // Reset value of input after loading because Chrome will not fire
    // a 'change' event if the same file is loaded again.
    document.getElementById('load').value = '';
  };
  reader.readAsText(files[0]);
}

function create_url(event) {
  var l = window.location;
  var base_url = l.protocol + '//' + l.hostname + l.pathname;
  var count = Blockly.mainWorkspace.getAllBlocks().length;
  if (count > 0) {
    var xml = Blockly.Xml.workspaceToDom(Blockly.mainWorkspace);
    var xml_str = Blockly.Xml.domToText(xml);
    var encoded_xml = encodeURIComponent(xml_str);
    if (encoded_xml.length > 2048) {
        alert("Trop de blocs, utiliser Export.");
    } else {
        window.location.assign(base_url + '?' + encoded_xml);
    }
  } else {
    window.location.assign(base_url);
  }
}

function load_query_string(str) {
  try {
    var xml = Blockly.Xml.textToDom(str);
  } catch (e) {
    alert('Error parsing XML:\n' + e);
    return;
  }
  Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, xml);
}
