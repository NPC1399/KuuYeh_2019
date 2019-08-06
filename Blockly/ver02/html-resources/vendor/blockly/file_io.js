function pad_to_2_chars_with_zeros(str) {
    if (str.length == 1) return "0" + str;
    else return str;
}

function yyyymmdd_hhmm() {
    d = new Date();
    return String(d.getFullYear()) +
           pad_to_2_chars_with_zeros(String(d.getMonth() + 1)) +
           pad_to_2_chars_with_zeros(String(d.getDate())) +
           "_" +
           pad_to_2_chars_with_zeros(String(d.getHours())) +
           pad_to_2_chars_with_zeros(String(d.getMinutes()));
}

// Taken from:
// https://github.com/gasolin/BlocklyDuino/blob/master/blockly/apps/blocklyduino/blockly_helper.js
// 2013/3/8
function filesave(data, type, filename) {
    var blob = new Blob([data], {type: type});
    saveAs(blob, filename);
}
