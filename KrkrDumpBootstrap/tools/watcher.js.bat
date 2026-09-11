rem()/*
@cls
@rem bat start
call d:\tools\open++\e\xcmd.cmd
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
const fs = require('fs');
const path = require('path');
const chokidar = require('chokidar');
const HxHash = require("./bootstrap/HxHash.js");
// let androidlog = require("androidlog");
// let logcat = androidlog("SMALI-WC");
// let alog = logcat.debug;
let log = console.log;
const mytools = require('mytools');

const eachFile = mytools.eachFile;

process.stdout.write('\x1Bc');

function EvstrtoLocaleString(ev) {
    const evstr = {
        'add': '文件新增',
        'change': '文件修改',
        'unlink': '文件删除',
        'addDir': '目录新增',
        'unlinkDir': '目录删除',
        'error': '监听错误'
    };
    if (evstr[ev])
        return evstr[ev];
    return ev;
}
const config = {
    persistent: true,
    depth: Infinity, // 子目录深度
    ignoreInitial: true, // 启动时不扫一遍
    followSymlinks: false, // 避免死循环
    usePolling: false, // 默认事件驱动
    awaitWriteFinish: {
        stabilityThreshold: 300,
        pollInterval: 100
    }
};

const watcher = new chokidar.FSWatcher(config);
watcher.on("all", onFSEvent)
watcher.on("error", console.log)

var basedir = "/storage/emulated/0/Android/data";
const dirs = [{
        name: "KRD1",
        path: "G:\\ksl\\ksl"
    }, {
        name: "KRD2",
        path: "K:\\ksl"
    }
];
log("Watcher")
let count = 0;
for (let dir of dirs) {
    log("Watching", dir.name, dir.path)
    watcher.add(dir.path);
    // eachFile(dir.path, dir.path, findOne)
}
function findOne(dirin, dirout, pin, fin, pout, fout) {
    var pinf = path.join(dirin, pin, fin);
    log(pin + "/" + fin)
    if (!fs.existsSync(pinf)) {
        return;
    }
    log("ADD " + pinf)
    watcher.add(pinf);
    count++;
    log("current count " + count)
}
function onFSEvent(event, path) {
    let str = path;
    for (let dir of dirs) {
        str = str.replace(dir.path, dir.name);
    }
    str = EvstrtoLocaleString(event) + ": " + str;
    log(str)
    // log(new Date().toLocaleString('zh-CN', {hour12: false}) + " " + str)
}
