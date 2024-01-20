const { execSync } = require('child_process');
const glob = require('glob');

const files = glob.sync('artifacts/contracts/**/!(*.dbg).json');
for (const file of files) {
  try {
    execSync(`npx typechain --target ethers-v6 '${file}'`);
    console.log(`Processed: ${file}`);
  } catch (error) {
    console.error(`Error processing ${file}: ${error}`);
  }
}
