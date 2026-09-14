const hxhash = require("./HxHash");
const fs = require('fs');
const chokidar = require('chokidar');
const config = {
    persistent: true,
    depth: Infinity, // 子目录深度
    // ignoreInitial: true, // 启动时不扫一遍
    followSymlinks: false, // 避免死循环
    usePolling: false, // 默认事件驱动
    awaitWriteFinish: {
        stabilityThreshold: 300,
        pollInterval: 100
    }
};
const table = {};
let list = [];
let txt = fs.readFileSync("I:/ryuu/HanaganeKanadeGram/UnknownFileName.txt", "utf8");
// main()
watch()
function main() {
    process.stdout.write('\x1Bc');
    let times = ["", "a", "b", "c", "d", "e", "f", "g", "h", "i"];
    let diffs = ["", "a", "b", "c", "d", "e", "f", "g",
        "h", "i", "j", "k", "l", "m", "n",
        "o", "p", "q", "r", "s", "t",
        "u", "v", "w", "x", "y", "z"];
    let dx = ["", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    for (let i = 1; i < 26; i++) {
        // for (let diff1 of diffs) {
        // for (let diff2 of diffs) {
        // for (let diff3 of diffs) {
        diff1 = "s";
        diff2 = "t";
        diff3 = "r"
            check("5fd_sys_" + diff1 + diff2 + diff3 + i.toString().padStart(3, "0") + ".opus")
            // }
            // }
            // }
    }
    console.log(list.join("\r\n"))
}
function watch() {
    const watcher = new chokidar.FSWatcher(config);
    watcher.on("all", onFSEvent)
    watcher.on("error", console.log)
    watcher.add("../krkrpatch/krdlist.txt");
}
function check(line) {
    let result = "X:" + line;
    let hash = hxhash.namehash(line);
    if (txt.indexOf(hash) != -1) {
        result = hash + ":" + line;
        list.push(line)
    } else if (txt.indexOf(line) != -1) {
        result = "F:" + hash + ":" + line;

    }
    console.log(result)
}
function onFSEvent(event, path) {
    process.stdout.write('\x1Bc');
    let lines = fs.readFileSync(path, "utf8").split(/\r?\n/);
    list = [];
    for (let line of lines) {
        line = line.trim();
        if (line == "") {
            continue;
        }
        check(line)
    }
    console.log(list.join("\r\n"))
}
