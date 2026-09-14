rem()/*
@cls
@rem bat start
@cd /d %~dp0
@set V0=%0
@echo.%V0%

:SERSTART
@D:\tools\Nodejs\node %V0% %*
@echo.%errorlevel%
@pause
@goto :SERSTART

@goto :EOS
@rem bat end
rem ()  */

/*jslint esversion:6, asi:true */
function rem() {}
/* Javascript start */

'use strict';
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

const ukn = "I:/DC/DC5SH/UnknownFileName.txt";

const table = {};
let list = [];
let txt = fs.readFileSync(ukn, "utf8");
const Console = require('console').Console;
const logger = new Console(fs.createWriteStream("MY-list.txt")).log;

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
    // check("dc5_cut033a.png")
    // return;
    // for (let i = 0; i < 999; i++) {
    for (let diff1 of diffs) {
        for (let diff2 of diffs) {
            for (let diff3 of diffs) {
                // diff1 = "s";
                // diff2 = "t";
                // diff3 = "r";
                // let xname = "bgm_dc5_" + (i.toString().padStart(3, "0")) + ".opus";
                // let xname = "ev0" + (i.toString().padStart(3, "0")) + diff1 + diff2 + ".png";
                let xname = "eye_" + diff1 + diff2 + diff3 + "_a.png";
                console.log(xname)
                check(xname)
                // check("diff_" + xname)
            }
        }
    }
    // }
    process.stdout.write('\x1Bc');
    console.log(list.join("\r\n"))
}
function watch() {

    const watcher = new chokidar.FSWatcher(config);
    watcher.on("all", onFSEvent)
    watcher.on("error", console.log)
    watcher.add("../krkrpatch/krdlist.txt");
    watcher.add("R:/krdlist.txt");

    config.ignoreInitial = true;
    const watcher2 = new chokidar.FSWatcher(config);
    watcher2.on("all", (path) => {
        txt = fs.readFileSync(path, "utf8");
        onFSEvent("", "../krkrpatch/krdlist.txt")
    })
    watcher2.on("error", console.log)
    watcher2.add(ukn);

}
function check(line) {
    let result = "X:" + line;
    let hash = hxhash.namehash(line);
    if (txt.indexOf(hash) != -1) {
        result = hash + ":" + line;
        list.push(line)
        logger(line)
    } else if (txt.indexOf(line) != -1) {
        result = "F:" + hash + ":" + line;

    }
    // console.log(result)
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
        console.log(line)
        check(line)
    }
    console.log(list.join("\r\n"))
}
