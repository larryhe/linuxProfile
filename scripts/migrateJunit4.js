#!/usr/bin/env node

const fs = require('fs');
const { execSync } = require('child_process');

const args = process.argv.slice(2);
if(args.length < 1) {
    console.log(`Usage: migrateJunit4.js files-to-migrate`);
    process.exit(1);
}

const isBlockClose = (body) => {
    let start = 0;
    body.forEach(line => {
        if(line.indexOf('//') === -1){
            start+= line.split('{').length -1;
            start-= line.split('}').length -1;
        }
    });
    if(start < 1) {
        console.log(`?????? error happening while process ${source}`);
    }
    return start === 1;
};

const source = args[0];
const pattern = /@Test\(expected\s*=\s*((\w+\.)+class)\)/;
const lines = fs.readFileSync(source, 'utf8').split('\n');
const newLines = [];
let foundExpected = false;
let testMethodStart = false;
let block = [];
const indent = '    ';
const assertImport = 'import static org.junit.jupiter.api.Assertions.assertThrows;';
let imported = false;
lines.forEach(line => {
    if(foundExpected){
        if(testMethodStart) {
            if(/\}$/.test(line) && isBlockClose(block)){
                testMethodStart = false;
                foundExpected = false;
                block.push(`${indent}${indent}});`);
                newLines.push(block.join('\n'));
                newLines.push(line);
            }else{
                block.push(`${indent}${line}`);
            }
        }else{
            if(/\{$/.test(line)) {
                testMethodStart = true;
                newLines.push(line);
            }else{
                console.log(`?????? more_than_one_annotations on line ${line} of file ${source}`);
                newLines.push(line);
            }
        }
    }else{
        const match = pattern.exec(line);
        if(match && match.length >= 2) {
            console.log(`==========expected Test found ${match[0]}`);
            newLines.push('    @Test');
            foundExpected = true;
            block=[];
            block.push(`        assertThrows(${match[1]}, () -> {`);
        }else{
            if(!imported && /^import/.test(line)){
                newLines.push(assertImport);
                imported = true;
            }
            if(line != assertImport) {
                newLines.push(line);
            }
        }
    }
});

fs.writeFileSync(`${source}.bk`, newLines.join('\n'), 'utf8');
console.log(`.........process file ${source}`);
execSync(`mv ${source}.bk ${source}`);
