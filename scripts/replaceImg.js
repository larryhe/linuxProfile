#!/usr/bin/env node

const path = require('path');
const fs = require('fs');

const replace = (file, oldName, newName) => {
    if(fs.existsSync(file)) {
        const dest = `${file}.bk`;
        const content = fs.readFileSync(file, 'utf8');
        const output = content.replace(new RegExp(oldName, 'g'), newName);
        fs.writeFileSync(dest, 'utf8');
    }
}

const args = process.argv.slice(2);
if(args.length < 3) {
    console.log(`Usage: replaceImg.js file-to-replace oldPattern newPattern`);
    process.exit(1);
}

const tmp = args[0];
replace.apply(null, args);
fs.renameSync(`${tmp}.bk`, tmp);
