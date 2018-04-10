#!/usr/bin/env node

const fs = require('fs');
const { execSync } = require('child_process');

const lines = fs.readFileSync('/Users/larryhe/tmp/vault.image.test.csv', 'utf8').split('\n');
lines.forEach(line => {
    if(line) {
        const fields = line.split(',');
        let new_name = fields[1] ? fields[1] : fields[0];
        let files = null;
        try{
            // files = execSync(`ack --css --less --hbs --js --jsp --java \'\\b${fields[0]}\\b\' -l`);
            files = execSync(`ack --js \'\\b${fields[0]}\\b\' -l`);
        }catch(error) {
            console.log(`IMAGE ${fields[0]} is not used anymore`);
            console.log(`mv ${fields[0]} to legacy`);
            execSync(`mv src/main/webapp/images/${fields[0]} src/main/webapp/images/legacy/`);
        }
        if(files) {
            if(fields[1]) {
                if(fields[2]){
                    new_name = `/${fields[2]}/${new_name}`;
                }else{
                    new_name = `/${new_name}`;
                }
                if(new_name !== `/${fields[0]}`){
                    console.log(`mv src/main/webapp/images/${fields[0]} src/main/webapp/images${new_name}`);
                    // execSync(`mv src/main/webapp/images/${fields[0]} src/main/webapp/images${new_name}`);
                }
            }
            files = files.toString();
            files.split('\n').forEach(file => {
                if(file){
                    console.log(`sed -i \'\' \'s|/${fields[0]}|${new_name}|g\' ${file}`);
                    execSync(`sed -i \'\' \'s|/${fields[0]}|${new_name}|g\' ${file}`);
                }
            });
        }
    }
});
